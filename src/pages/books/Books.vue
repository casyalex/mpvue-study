<template>
  <div>
    <card v-for="book in books" :key="book.id" :book="book"></card>
  </div>
</template>

<script>
import {get} from '@/util'
import card from '@/components/Card'
export default {
  components: {
    card
  },
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

