<template>
  <div class="space-y-2 text-black hover:bg-gray-100 p-10 rounded-lg shadow-lg max-w-xl mx-auto">
    <a class='hover:text-current' :href="this.flatObject.href" target='_blank'>
      <div class="block py-1 border-black-100 text-center">
         Enviado hace {{ time_ago }} 
      </div>
      <span class="flex space-x-4"> 
        <div class="flex-2 text-center w-40">
          <h1 class="font-black">{{ flatObject.name }}</h1>
        </div>
        <div class="flex-1 justify-center space-y-2">
          <p>{{ flatObject.price }}</p>
          <p>{{ flatObject.specs }}</p>
          <p>{{ flatObject.location }}</p>
        </div>
      </span>
    </a>
    <button v-on:click="likeFlat()" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded inline-flex items-center">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" :fill="this.button_color">
          <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd" />
        </svg>
      <span>Favoritos</span>
    </button>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: 'Flat',
  data: function () {
    return {
      flatObject: {},
    }
  },
  computed: {
    button_color() {
      if (this.flatObject.liked) {
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
    this.flatObject = JSON.parse(this.flat_json)
  },
  methods: {
    likeFlat() {
      this.flatObject.liked = !this.flatObject.liked
      axios
        .put(`http://localhost:3000/api/v1/search_param_flats/${this.flatObject.search_param_flat_id}`, {
          id: this.flatObject.search_param_flat_id,
          liked: this.flatObject.liked,
        })
        .then(response => {
        console.log(response);
        this.initialize();
        })
        .catch(error => {
        console.log(error);
      });
    },
  }

}
</script>