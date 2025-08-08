export const compressAndConvertImage = (
  input: Uint8Array | number[] | File | Blob,
  maxSizeKB: number,
  maxWidth: number = 300,
  maxHeight: number = 300
): Promise<Uint8Array> => {
  return new Promise((resolve, reject) => {
    if (!input) return reject(new Error("No file provided"))

    let file: Blob

    if (input instanceof Uint8Array) {
      file = new Blob([input], { type: "image/jpeg" })
    } else if (input instanceof File || input instanceof Blob) {
      file = input
    } else if (Array.isArray(input)) {
      const uint8Array = new Uint8Array(input)
      file = new Blob([uint8Array], { type: "image/jpeg" })
    } else {
      return reject(new Error("Unsupported input type"))
    }

    const reader = new FileReader()
    reader.readAsDataURL(file)

    reader.onload = (e: ProgressEvent<FileReader>) => {
      const result = e.target?.result
      if (typeof result !== "string") return reject(new Error("Invalid data URL"))

      const img = new Image()
      img.src = result

      img.onload = () => {
        const canvas = document.createElement("canvas")
        const ctx = canvas.getContext("2d")

        if (!ctx) return reject(new Error("Failed to get canvas context"))

        let width = img.width
        let height = img.height

        if (width > maxWidth || height > maxHeight) {
          const aspectRatio = width / height
          if (width > height) {
            width = maxWidth
            height = maxWidth / aspectRatio
          } else {
            height = maxHeight
            width = maxHeight * aspectRatio
          }
        }

        canvas.width = width
        canvas.height = height
        ctx.drawImage(img, 0, 0, width, height)

        let quality = 0.7

        const compressImage = () => {
          canvas.toBlob(
            (blob) => {
              if (!blob) return reject(new Error("Failed to create blob"))

              if (blob.size > maxSizeKB * 1024 && quality > 0.1) {
                quality -= 0.1
                compressImage()
              } else {
                const reader = new FileReader()
                reader.readAsArrayBuffer(blob)
                reader.onload = () => {
                  const result = reader.result
                  if (!(result instanceof ArrayBuffer)) return reject(new Error("Invalid ArrayBuffer"))
                  const uint8Array = new Uint8Array(result)
                  resolve(uint8Array)
                }
                reader.onerror = reject
              }
            },
            "image/jpeg",
            quality
          )
        }

        compressImage()
      }

      img.onerror = reject
    }

    reader.onerror = reject
  })
}

export const blobToImageUrl = (imageData: Uint8Array | number[] | null): string | null => {
  if (!imageData || imageData.length === 0) return null
  const blob = new Blob([new Uint8Array(imageData)], { type: "image/jpeg" })
  return URL.createObjectURL(blob)
}

export function uint8ArrayToBase64(uint8Array: Uint8Array): string {
  let binary = '';
  for (let i = 0; i < uint8Array.length; i++) {
      binary += String.fromCharCode(uint8Array[i] as number);
  }
  return btoa(binary);
}
