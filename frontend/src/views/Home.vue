<template>
  <v-container>
    <search-bar @keyword="this.keywordChanged" />
    
    <div v-if="storedKeyword.length == 0">No results found.</div>
    <div v-else-if="results.length == 0 && storedKeyword.length > 0">No results found for {{storedKeyword}}</div>
    <search-results v-else :results="results" />
  </v-container>
</template>

<script>
  import SearchBar from '@/components/SearchBar.vue'
  import SearchResults from '@/components/SearchResults.vue'

  // Make sure the VITE_REST_API environment variable is set when calling npm run build, so that correct backend url is used.
  const restUrl = import.meta.env.VITE_REST_API || 'http://localhost:3000';

  export default {
    components: {
      SearchBar, SearchResults
    },
    data() {
        return {
            storedKeyword: "",
            results: []
        }
    },
    mounted() {
      this.logHost()
    },
    methods: {
      logHost(){
        fetch(`${restUrl}/status`, {
          method: 'GET'
        })
        .then(response => response.json())
        .then(response => console.log('Hostname:', response.hostname))
        .catch(error => {
          console.error('Error occured:', error);
        })
      },
      keywordChanged(keyword) {
        this.storedKeyword = keyword
        fetch(`${restUrl}/search?shortname=${keyword}`, {
          method: 'GET'
        })
        .then(response => response.json())
        .then(response => this.results = response)
        .catch(error => {
          console.error('Error occured:', error);
        })
      }
    }
}
</script>
