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
      wx.showNavigationBarLoading()
      const books = await get('/weapp/booklist')
      console.log(books)
      this.books = books.list

      wx.stopPullDownRefresh()
      wx.hideNavigationBarLoading()
    }
  },
  onPullDownRefresh () {
    this.getList()
  },
  mounted () {
    this.getList()
  }
}
</script>

<style lang="stylus" scoped>

</style>

