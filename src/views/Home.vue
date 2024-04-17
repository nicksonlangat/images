<template>
<div class="h-screen font-base text-[#d7d7d9]  flex flex-col overflow-hidden">
    <!-- Fixed top nav -->
    <nav class="flex flex-none border-b border-[#262628] items-center py-2 justify-between flex-wrap">
        <h1 class="p-3">
            <!-- Logo -->
        </h1>

    </nav>
    <!-- Main content -->
    <div class="flex-1 flex overflow-hidden">
        <ImageModal />
        <Notification />
        <!-- Fixed sidebar -->
        <div class="w-40 sm:w-64 border-r border-[#262628]">
            <div class="p-3">
                <div class="flex gap-2 items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-device-floppy">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                        <path d="M6 4h10l4 4v10a2 2 0 0 1 -2 2h-12a2 2 0 0 1 -2 -2v-12a2 2 0 0 1 2 -2" />
                        <path d="M12 14m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0" />
                        <path d="M14 4l0 4l-6 0l0 -4" /></svg>
                    Local images
                </div>

                <div class="grid mt-5 lg:grid-cols-2 gap-5">
                    <div v-for="i in 4" class="bg-[#272729] flex items-center justify-center text-[#d7d7d9]/20 cursor-pointer h-28 border border-[#d7d7d9]/20 border-dashed rounded-md">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-photo">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                            <path d="M15 8h.01" />
                            <path d="M3 6a3 3 0 0 1 3 -3h12a3 3 0 0 1 3 3v12a3 3 0 0 1 -3 3h-12a3 3 0 0 1 -3 -3v-12z" />
                            <path d="M3 16l5 -5c.928 -.893 2.072 -.893 3 0l5 5" />
                            <path d="M14 14l1 -1c.928 -.893 2.072 -.893 3 0l3 3" /></svg>
                    </div>
                </div>
                <div class="flex mt-10 gap-2 items-center">

                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-star">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                        <path d="M12 17.75l-6.172 3.245l1.179 -6.873l-5 -4.867l6.9 -1l3.086 -6.253l3.086 6.253l6.9 1l-5 4.867l1.179 6.873z" /></svg>
                    Favourites
                </div>
                <div class="grid mt-5 lg:grid-cols-2 gap-5">
                    <img v-for="image in images.slice(-4)" @click="openModal(image)" class="h-32 w-full cursor-pointer rounded-md object-cover" :src="image.url" alt="">
                </div>

            </div>
        </div>
        <!-- Scroll wrapper -->
        <div class="flex-1 flex-col flex">
            <div class="border-b border-[#262628] py-2">
                <div class="p-3">
                    <div class="flex justify-between">
                        <p class="text-[#d7d7d9]/60">AI Image Generation</p>
                        <div class="flex gap-2 items-center">
                            <p class="text-[#d7d7d9]/60">Allow negative prompts</p>
                            <input type="checkbox" checked class="rounded h-5 bg-[#ff6d3c] focus:border-0 w-5 focus:ring-0 focus:outline-none text-[#ff6d3c] accent-[#ff6d3c]">
                        </div>

                    </div>
                    <div class="flex justify-between gap-5 mt-5">
                        <input type="text" v-model="url" class="py-2 border-[#d7d7d9]/20 placeholder:text-[#d7d7d9]/60 text-xs bg-[#272729] rounded-md w-full focus:border focus:border-[#ff6d3c] focus:ring-0 focus:outline-none" placeholder="Prompt or link">

                        <div class="flex gap-5">
                            <button @click="uploadImage" class="bg-[#ff6d3c] inline-flex gap-2 py-2 rounded-md px-4">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-cloud-upload">
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                    <path d="M7 18a4.6 4.4 0 0 1 0 -9a5 4.5 0 0 1 11 2h1a3.5 3.5 0 0 1 0 7h-1" />
                                    <path d="M9 15l3 -3l3 3" />
                                    <path d="M12 12l0 9" /></svg>
                                Upload</button>
                            <button @click="dispatchNotification" class="bg-[#ff6d3c] inline-flex gap-2 items-center py-2 rounded-md px-4">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-sparkles">
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                    <path d="M16 18a2 2 0 0 1 2 2a2 2 0 0 1 2 -2a2 2 0 0 1 -2 -2a2 2 0 0 1 -2 2zm0 -12a2 2 0 0 1 2 2a2 2 0 0 1 2 -2a2 2 0 0 1 -2 -2a2 2 0 0 1 -2 2zm-7 12a6 6 0 0 1 6 -6a6 6 0 0 1 -6 -6a6 6 0 0 1 -6 6a6 6 0 0 1 6 6z" /></svg>
                                Generate</button>
                        </div>
                    </div>

                </div>

            </div>
            <!-- Scrollable container -->
            <div class="px-6 py-4 flex-1 overflow-y-auto">
                <!-- Your content -->
                <div class="grid lg:grid-cols-4 gap-5">
                    <img v-for="image in images" @click="openModal(image)" class="h-64 w-full cursor-pointer rounded-md object-cover" :src="image.url" alt="">
                </div>
                <!--  -->
            </div>
        </div>
        <div class="w-40 sm:w-64 text-[#d7d7d9] border-l border-[#262628]">
            <div class="p-3">
                <div class="flex gap-2 items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-components">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                        <path d="M3 12l3 3l3 -3l-3 -3z" />
                        <path d="M15 12l3 3l3 -3l-3 -3z" />
                        <path d="M9 6l3 3l3 -3l-3 -3z" />
                        <path d="M9 18l3 3l3 -3l-3 -3z" /></svg>
                    Model
                </div>
                <select class="py-2 mt-5 border-[#d7d7d9]/20 focus:border focus:border-[#ff6d3c] text-sm bg-[#272729] rounded-md w-full focus:ring-0 focus:outline-none">
                    <option value="">
                        DALL-E
                    </option>
                    <option value="">
                        Stable Diffusion
                    </option>
                    <option value="">
                        Midjourney
                    </option>
                    <option value="">
                        Imagen
                    </option>
                    <option value="">
                        GauGAN
                    </option>
                </select>

                <div class="flex mt-10 gap-2 items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-adjustments">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                        <path d="M4 10a2 2 0 1 0 4 0a2 2 0 0 0 -4 0" />
                        <path d="M6 4v4" />
                        <path d="M6 12v8" />
                        <path d="M10 16a2 2 0 1 0 4 0a2 2 0 0 0 -4 0" />
                        <path d="M12 4v10" />
                        <path d="M12 18v2" />
                        <path d="M16 7a2 2 0 1 0 4 0a2 2 0 0 0 -4 0" />
                        <path d="M18 4v1" />
                        <path d="M18 9v11" /></svg>
                    Adjustments
                </div>

                <div class="flex text-sm flex-col gap-5 divide-y divide-[#262628]">
                    <div class="flex text-[#d7d7d9]/60 mt-5 justify-between items-center">
                        Prompt weight
                        <input type="text" class="py-2 text-xs bg-[#272729] border-[#d7d7d9]/20 rounded-md w-10 focus:border focus:border-[#ff6d3c] focus:ring-0 focus:outline-none">
                        <input type="range" value="100" min="10" max="100" class="w-20 h-2 bg-[#ff6d3c] accent-[#ff6d3c] rounded-lg appearance-none cursor-pointer ">
                    </div>
                    <div class="flex text-[#d7d7d9]/60 py-5 justify-between items-center">
                        Image weight
                        <input type="text" class="py-2 text-xs bg-[#272729] border-[#d7d7d9]/20 rounded-md w-10 focus:border focus:border-[#ff6d3c] focus:ring-0 focus:outline-none">
                        <input type="range" value="100" min="10" max="100" class="w-20 h-2 bg-[#ff6d3c] accent-[#ff6d3c] rounded-lg appearance-none cursor-pointer ">
                    </div>
                    <div class="flex text-[#d7d7d9]/60 justify-between py-5 gap-2 items-center">
                        Softness
                        <input type="text" class="py-2 text-xs bg-[#272729] border-[#d7d7d9]/20 rounded-md w-10 focus:border focus:border-[#ff6d3c] focus:ring-0 focus:outline-none">
                        <input type="range" value="100" min="10" max="100" class="w-20 h-2 bg-[#ff6d3c] accent-[#ff6d3c] rounded-lg appearance-none cursor-pointer ">
                    </div>

                </div>
                <div class="flex mt-10 gap-2 items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-photo">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                        <path d="M15 8h.01" />
                        <path d="M3 6a3 3 0 0 1 3 -3h12a3 3 0 0 1 3 3v12a3 3 0 0 1 -3 3h-12a3 3 0 0 1 -3 -3v-12z" />
                        <path d="M3 16l5 -5c.928 -.893 2.072 -.893 3 0l5 5" />
                        <path d="M14 14l1 -1c.928 -.893 2.072 -.893 3 0l3 3" /></svg>
                    Image Dimensions
                </div>
                <div class="grid grid-cols-2 gap-5 mt-5">

                    <button v-for="dimension in image_dimensions" class="bg-[#272729] rounded-md text-sm py-2">
                        {{ dimension }}
                    </button>
                </div>
            </div>

        </div>
    </div>

</div>
</template>

<script>
import ImageModal from '@/components/ImageModal.vue'
import Notification from "@/components/Notification.vue"
import moment from 'moment'
import axios from 'axios'
export default {
    components: {
        ImageModal,
        Notification
    },
    data() {
        return {
            baseURL: process.env.VUE_APP_BASE_URL,
            url: "",
            images: [],
            image_dimensions: [
                "512 x 512",
                "768 x 768",
                "512 x 1024",
                "768 x 1024",
                '1024 x 768',
                "1024 x 1024"
            ],
        }
    },
    methods: {
        openModal(image) {
            this.emitter.emit("openModal", {
                "image": image,
                "view": true
            })
        },
        uploadImage() {
            axios.post(`${this.baseURL}collectedimages/`, {
                "url": this.url
            }).then(res => {
              this.emitter.emit("showNotification", {
                "success": true,
                "title": "Request successful.",
                "message": "Your image has been saved."
            })
                this.getImages()
            }).catch(error=>{
              this.emitter.emit("showNotification", {
                "success": false,
                "title": "Error encountered.",
                "message": "Please check the form input then re-submit."
            })
            })
        },

        newImage() {
            this.emitter.emit("openModal", {
                "view": false
            })
        },
        dispatchNotification() {
            this.emitter.emit("showNotification", {
                "success": true,
                "title": "Coming soon",
                "message": "Feature development in progress."
            })
        },
        getImages() {
            axios.get(`${this.baseURL}collectedimages/`).then(res => {
                this.images = res.data
            })
        }
    },
    mounted() {
        this.getImages()
        this.emitter.on("refresh", data => {
            this.getImages()
        })
    }
}
</script>

<style>
body,
html {
    background-color: #18181a;
}

::-webkit-scrollbar {
    width: 0;
    /* Remove scrollbar space */
    background: transparent;
    /* Optional: just make scrollbar invisible */
}
</style>
