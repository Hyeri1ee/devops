<template>
  <form>
    <v-text-field v-model="keyword" label="Please enter the shortname here" @input="$emit('keyword', this.keyword)"></v-text-field>
  </form>
</template>

<script>
export default {
    data() {
        return {
            keyword: ''
        }
    },
    emits: ['keyword']
}
</script>