<template>
<TransitionRoot :show="isOpen" enter='transform 
transition ease-in-out duration-1000' enterFrom='translate-x-full' enterTo='translate-x-0' leave="transition
 ease-in-out duration-1000 transform" leave-from="translate-x-0" leave-to="translate-x-50" class="flex flex-col
  absolute w-72 p-1.5 right-0
 top-5 mb-4 font-base border-[#d7d7d9]/20  bg-[#28282a] border  rounded-md shadow" role="alert">
    <div class="inline-flex ml-2 gap-2 text-sm items-center flex-shrink-0 text-white">
        <svg v-if="success" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="
        h-5 w-5 text-[#1ED760]">
            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
            <path d="M12 12m-9 0a9 9 0 1 0 18 0a9 9 0 1 0 -18 0" />
            <path d="M9 12l2 2l4 -4" /></svg>
        <svg v-if="!success" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-red-500 h-5 w-5">
            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
            <path d="M12 12m-9 0a9 9 0 1 0 18 0a9 9 0 1 0 -18 0" />
            <path d="M12 9v4" />
            <path d="M12 16v.01" /></svg>
        {{ title }}
    </div>

    <div class="mt-2 ml-3 text-xs text-white font-base">{{ message }}</div>

</TransitionRoot>
</template>

<script>
import {
    TransitionRoot,
    TransitionChild,
} from '@headlessui/vue'
export default {
    components: {
        TransitionRoot,
        TransitionChild,
    },
    data() {
        return {
            isOpen: false,
            success: false,
            message: "",
            title: ""
        }
    },
    methods: {
        toggleModal() {
            this.isOpen = !this.isOpen
        }
    },
    mounted() {
        this.emitter.on("showNotification", data => {
            this.success = data.success
            this.message = data.message
            this.title = data.title
            this.toggleModal()
            setTimeout(() => this.isOpen = false, 2000)
        })
    }
}
</script>
