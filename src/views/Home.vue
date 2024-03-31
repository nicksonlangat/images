<template>
<div class="flex font-base flex-col h-screen items-center justify-center ">
    <header class="w-full text-center border-b border-[#333333] p-4 sticky top-0">
      <nav class="flex mx-auto container justify-between">
       
          <span class="bg-[#333333] text-[#aaaaaa] px-2 py-2 rounded-md flex">
            <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-photo-star"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M15 8h.01" /><path d="M11 21h-5a3 3 0 0 1 -3 -3v-12a3 3 0 0 1 3 -3h12a3 3 0 0 1 3 3v5.5" /><path d="M3 16l5 -5c.928 -.893 2.072 -.893 3 0l2 2" /><path d="M17.8 20.817l-2.172 1.138a.392 .392 0 0 1 -.568 -.41l.415 -2.411l-1.757 -1.707a.389 .389 0 0 1 .217 -.665l2.428 -.352l1.086 -2.193a.392 .392 0 0 1 .702 0l1.086 2.193l2.428 .352a.39 .39 0 0 1 .217 .665l-1.757 1.707l.414 2.41a.39 .39 0 0 1 -.567 .411l-2.172 -1.138z" /></svg>
        
          </span> 
        
        <button @click="newImage" class="py-2 text-white px-4 border border-[#333333] text-xs rounded-md">Add asset</button>
      </nav>
    </header>
    <ImageModal/>
    <main class="flex-1 mx-5 lg:mx-0  overflow-y-scroll">
        <div class="min-h-screen flex  flex-col w-full max-w-5xl ">

            <div class="grid mt-5 lg:grid-cols-3 gap-5">
              <img v-for="image in images" @click="openModal(image)" class="h-72 w-full cursor-pointer rounded-md object-cover" :src="image.url" alt="">
            </div>
        </div>
        <!-- <div class="min-h-screen bg-slate-200">
            <p>This is second long section that consumes 100% viewport height!</p>
        </div> -->
        
    </main>
    <!-- <footer class="w-full text-center border-t border-grey p-4 sticky bottom-0">some footer</footer> -->
</div>
</template>

<script>
import ImageModal from '@/components/ImageModal.vue'
import moment from 'moment'
import axios from 'axios'
export default {
    components: {
      ImageModal
    },
    data () {
      return {
        baseURL: process.env.VUE_APP_BASE_URL,
        images: [
          // "https://pbs.twimg.com/media/GJ6JmxtXQAAMhAv?format=png&name=4096x4096",
          // "https://pbs.twimg.com/media/GJ6Jmx1WMAEiaoL?format=jpg&name=4096x4096",
          // "https://pbs.twimg.com/media/GJ6JmxzWcAAeyFk?format=jpg&name=4096x4096",
          // "https://pbs.twimg.com/media/EtIpvaeXEAMCkRZ?format=png&name=4096x4096",
          // "https://pbs.twimg.com/media/GJ437xjW8AAMNOF?format=jpg&name=4096x4096",
          // "https://pbs.twimg.com/media/GJpOKAJWcAAqBJe?format=jpg&name=large",
          // "https://pbs.twimg.com/media/GJpOJ-pXgAAS_fc?format=jpg&name=large",
          // "https://pbs.twimg.com/media/GJpOJ-_WAAAPHWs?format=jpg&name=large",
          // "https://pbs.twimg.com/media/GJjnvKwWcAApXLJ?format=jpg&name=large"
        ]
      }
    },
    methods: {
      openModal(image) {
        this.emitter.emit("openModal", {"image": image, "view": true})
      },

      newImage() {
        this.emitter.emit("openModal", {"view": false})
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
body, html {
  background-color: #222222;
}

::-webkit-scrollbar {
    width: 0;
    /* Remove scrollbar space */
    background: transparent;
    /* Optional: just make scrollbar invisible */
}
</style>

