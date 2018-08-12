<template>
  <div>
    <div v-for="book in books" :key="book.id">{{book.title}}</div>
  </div>
</template>

<script>
import {get} from '@/util'
export default {
  data () {
    return {
      books: []
    }
  },
  methods: {
    async getList () {
      const books = await get('/weapp/booklist')
      console.log(books)
      this.books = books.list
    }
  },
  mounted () {
    this.getList()
  }
}
</script>

<style lang="stylus" scoped>

</style>

