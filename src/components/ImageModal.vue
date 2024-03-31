<template>
<TransitionRoot appear :show="isOpen" as="template">
    <Dialog as="div" @close="closeModal" class="relative font-base z-10">
        <TransitionChild as="template" enter="duration-300 ease-out" enter-from="opacity-0" enter-to="opacity-100" leave="duration-200 ease-in" leave-from="opacity-100" leave-to="opacity-0">
            <div class="fixed inset-0 bg-black/30" />
        </TransitionChild>

        <div class="fixed inset-0 overflow-y-auto">
            <div class="flex min-h-full items-center justify-center p-4 text-center">
                <TransitionChild as="template" enter="duration-300 ease-out" enter-from="opacity-0 scale-95" enter-to="opacity-100 scale-100" leave="duration-200 ease-in" leave-from="opacity-100 scale-100" leave-to="opacity-0 scale-95">
                    <DialogPanel v-if="view" class="w-full mt-20 max-w-3xl transform overflow-hidden rounded-xl bg-[#1e1e1e] p-6 text-left align-middle shadow-xl transition-all">

                        <div>
                            <img style="height: 34rem;" class="rounded-xl object-cover w-full" :src="image.url" alt="">
                        </div>

                        <div class="mt-10 flex justify-between">
                            <div class="text-[#aaaaaa] text-sm">
                                <div class="flex flex-col gap-4">
                                    <span class="inline-flex gap-2">
                                        <svg xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 24 24" fill="currentColor" class="h-5 w-5">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                            <path d="M17 3.34a10 10 0 1 1 -14.995 8.984l-.005 -.324l.005 -.324a10 10 0 0 1 14.995 -8.336zm-5 2.66a1 1 0 0 0 -.993 .883l-.007 .117v5l.009 .131a1 1 0 0 0 .197 .477l.087 .1l3 3l.094 .082a1 1 0 0 0 1.226 0l.094 -.083l.083 -.094a1 1 0 0 0 0 -1.226l-.083 -.094l-2.707 -2.708v-4.585l-.007 -.117a1 1 0 0 0 -.993 -.883z" /></svg>
                                        {{ formatDate(image.created_at) }}
                                    </span>
                                    <span class="inline-flex gap-2">
                                        <svg xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-5 w-5">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                            <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2" />
                                            <path d="M7 11l5 5l5 -5" />
                                            <path d="M12 4l0 12" /></svg>
                                        {{ image.downloads }} times
                                    </span>
                                </div>
                            </div>
                            <div>
                                <button @click="downloadImage" class="bg-white focus:outline-none focus:ring-0 py-2 rounded-md px-4 text-sm">Download</button>
                            </div>
                        </div>
                    </DialogPanel>

                    <DialogPanel v-else class="w-full max-w-xl transform overflow-hidden rounded-xl bg-[#1e1e1e] p-6 text-left align-middle shadow-xl transition-all">
                        <div class=" flex gap-5 items-center">
                            <input v-model="image" type="text" class="border border-[#333333] text-[#aaaaaa] focus:outline-none focus:ring-0 text-sm placeholder:text-sm placeholder:text-[#aaaaaa] bg-inherit py-2 rounded-md pl-4 w-full" placeholder="Paste link to image">
                            <div>
                                <button @click="uploadImage" class="bg-white focus:outline-none focus:ring-0 py-2 rounded-md px-4 text-sm">Upload</button>
                            </div>
                        </div>
                    </DialogPanel>
                </TransitionChild>
            </div>
        </div>
    </Dialog>
</TransitionRoot>
</template>

<script>
import {
    TransitionRoot,
    TransitionChild,
    Dialog,
    DialogPanel,
    DialogTitle,
} from '@headlessui/vue'

import moment from 'moment'
import axios from 'axios'

export default {
    components: {
        TransitionRoot,
        TransitionChild,
        Dialog,
        DialogPanel,
        DialogTitle,
    },
    data() {
        return {
            isOpen: false,
            baseURL: process.env.VUE_APP_BASE_URL,
            image: "",
            view: false
        }
    },

    methods: {
        openModal() {
            this.isOpen = true
        },
        closeModal() {
            this.isOpen = false

        },
        formatDate(date) {
            return moment(date).format('MMM Do, YY')
        },
        uploadImage() {
            axios.post(`${this.baseURL}collectedimages/`, {
                "url": this.image
            }).then(res => {
                this.closeModal()
                this.emitter.emit("refresh", {})
            })
        },
        downloadImage() {
          this.image.url
          var a = document.createElement('a')
          a.href = this.image.url
          a.setAttribute("download", "data.png")
          a.target = '_blank'
          a.click()
        },
    },
    mounted() {
        this.emitter.on("openModal", data => {
            this.image = data.image
            this.view = data.view
            this.openModal()
        })
    },

}
</script>
