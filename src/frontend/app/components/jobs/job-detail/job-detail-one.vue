<template>
    <h5 class="text-lg font-semibold">Job Description:</h5>

    <p class="text-slate-400 mt-4">One disadvantage of Lorum Ipsum is that in Latin certain letters appear more frequently than others - which creates a distinct visual impression. Moreover, in Latin only words at the beginning of sentences are capitalized.</p>
    <p class="text-slate-400 mt-4">This means that Lorem Ipsum cannot accurately represent, for example, German, in which all nouns are capitalized. Thus, Lorem Ipsum has only limited suitability as a visual filler for German texts. If the fill text is intended to illustrate the characteristics of different typefaces.</p>
    <p class="text-slate-400 mt-4">It sometimes makes sense to select texts containing the various letters and symbols specific to the output language.</p>

    <h5 class="text-lg font-semibold mt-6">Responsibilities and Duties: </h5>
    <p class="text-slate-400 mt-4">It sometimes makes sense to select texts containing the various letters and symbols specific to the output language.</p>
    <ul class="list-none">
        <li v-for="item in datas" :key="item" class="text-slate-400 mt-2"><i class="uil uil-arrow-right text-emerald-600 me-1"></i>{{ item }}</li>
    </ul>

    <h5 class="text-lg font-semibold mt-6">Required Experience, Skills and Qualifications: </h5>
    <p class="text-slate-400 mt-4">It sometimes makes sense to select texts containing the various letters and symbols specific to the output language.</p>
    <ul class="list-none">
        <li v-for="item in datas2" :key="item" class="text-slate-400 mt-2"><i class="uil uil-arrow-right text-emerald-600 me-1"></i>{{item}}</li>
    </ul>

    <div class="mt-5">
        <router-link to="/job-apply" class="py-1 px-5 inline-block font-semibold tracking-wide border align-middle transition duration-500 ease-in-out text-base text-center rounded-md bg-emerald-600 hover:bg-emerald-700 border-emerald-600 hover:border-emerald-700 text-white md:ms-2 w-full md:w-auto">Apply Now</router-link>
    </div>
</template>

<script setup>
   const datas = ['Participate in requirements analysis', 'Write clean, scalable code using C# and .NET frameworks', 'Test and deploy applications and systems', 'Revise, update, refactor and debug code', 'Improve existing software', 'Develop documentation throughout the software development life cycle (SDLC', 'Serve as an expert on applications and provide technical support']

   const datas2 = ['Proven experience as a .NET Developer or Application Developer', 'good understanding of SQL and Relational Databases, specifically Microsoft SQL Server.', 'Experience designing, developing and creating RESTful web services and APIs', 'Basic know how of Agile process and practices', 'Good understanding of object-oriented programming.', 'Good understanding of concurrent programming.', 'Sound knowledge of            application architecture and design.', 'Excellent problem solving and analytical skills']
</script>

<style lang="scss" scoped></style>