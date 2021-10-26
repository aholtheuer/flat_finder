<template>
  <div class="space-y-2 text-black hover:bg-gray-100 p-10 rounded-xl shadow-xl max-w-xxl mx-auto">
    <a class='hover:text-current' :href="'/search_params/' + searchParamObject.id">
      <span class="flex space-x-4"> 
        <div class="flex-2 text-center w-40">
          <h1 class="font-black">{{ searchParamObject.title }}</h1>
        </div>
        <div class="flex-1 justify-center space-y-2">
          <p>{{ `Comuna: ${ searchParamObject.comuna }` }}</p>
          <p>{{ `Habitaciones: ${ searchParamObject.bedroom || '--' }` }}</p>
          <p>{{ `Baños: ${ searchParamObject.bath || '--' }` }}</p>
          <p>{{ `Precio Mínimo: ${ searchParamObject.price_min || '--' }` }}</p>
          <p>{{ `Precio Máximo: ${ searchParamObject.price_max || '--' }` }}</p>
        </div>
      </span>
    </a>
    <a class="inline-flex bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded inline-flex items-center hover:text-current" 
        :href="'/search_params/' + searchParamObject.id + '/edit'">
      Edit
    </a>
    <button v-on:click="deleteSearchParam()" 
        class="bg-red-400 text-white font-bold py-2 px-4 rounded inline-flex items-center hover:text-white hover:bg-red-500" >
        <!-- <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" :fill="this.button_color">
          <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd" />
        </svg> -->
      <span>Delete</span>
    </button>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: 'SearchParam',
  data: function () {
    return {
      searchParamObject: {},
    }
  },
  props: {
    search_param_json: String,
  },
  created() {
    this.searchParamObject = JSON.parse(this.search_param_json)
  },
  methods: {
    deleteSearchParam() {
      confirm("Are you sure you want to delete this search?"); 
      console.log("Delete")
      axios
        .delete(`http://localhost:3000/api/v1/search_params/${this.searchParamObject.id}`)
        .then(response => {
          console.log(response);
          console.log(response.data.json);
          alert(response.data.json);
          })
        .catch(error => {
          console.log(error);
        });
    }
  }
}
</script>