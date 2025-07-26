#!/bin/bash
INPUT="../../.env"
OUTPUT="./.env"

> "$OUTPUT" # Limpiar salida

while IFS= read -r line || [[ -n "$line" ]]; do
  # Si es un comentario o está vacío, lo copia tal cual
  if [[ "$line" =~ ^#.* || -z "$line" ]]; then
    echo "$line" >> "$OUTPUT"
  # Si ya empieza con VITE_, no lo toca
  elif [[ "$line" =~ ^VITE_.* ]]; then
    echo "$line" >> "$OUTPUT"
  # Si es una variable con formato KEY=VAL, agrega VITE_
  elif [[ "$line" =~ ^[A-Z0-9_]+=.* ]]; then
    echo "VITE_$line" >> "$OUTPUT"
  else
    echo "$line" >> "$OUTPUT" # Copia otras líneas tal cual
  fi
done < "$INPUT"

echo "✅ Archivo generado en: $OUTPUT"
