<template>
  <div class="space-y-2 text-black hover:bg-gray-100 p-10 rounded-lg shadow-lg max-w-xl mx-auto">
    <a class='hover:text-current' :href="this.results.href" target='_blank'>
      <div class="block py-1 border-black-100 text-center">
         Enviado hace {{ time_ago }} 
      </div>
      <span class="flex space-x-4"> 
        <div class="flex-2 text-center w-40">
          <h1 class="font-black">{{ results.name }}</h1>
        </div>
        <div class="flex-1 justify-center space-y-2">
          <p>{{ results.price }}</p>
          <p>{{ results.specs }}</p>
          <p>{{ results.location }}</p>
        </div>
      </span>
    </a>
    <button v-on:click="saveFlat()" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded inline-flex items-center">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" :fill="this.button_color">
          <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd" />
        </svg>
      <span>Favoritos</span>
    </button>
  </div>
</template>

<script>
export default {
  name: 'Flat',
  data: function () {
    return {
      results: {},
      // this saved must come within results?
      saved: false,
    }
  },
  computed: {
    button_color() {
      if (this.saved) {
        return 'red'
      } else {
        return 'current_color'
      }
    }
  },
  props: {
    flat_json: String,
    time_ago: String,
  },
  created() {
    this.results = JSON.parse(this.flat_json)
  },
  methods: {
    saveFlat() {
      this.saved = !this.saved
    },
  }

}
</script>