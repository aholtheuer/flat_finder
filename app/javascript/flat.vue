<template>
  <p>
    {{ results.name }}
    {{ results.price }}
    {{ results.specs }}
    {{ results.location }}
    {{ results.emailed_at }}


  </p>
</template>

<script>
export default {
  name: 'Flat',
  data: function () {
    return {
      results: {}
    }
  },
  props: {
    flat_json: String
  },
  created() {
      this.results = JSON.parse(this.flat_json)
    }
}
</script>