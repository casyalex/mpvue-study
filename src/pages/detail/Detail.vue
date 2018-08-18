<template>
  <div>
    <BookInfo :info="info"></BookInfo>
  </div>
</template>

<script>
import {get} from '@/util'
import BookInfo from '@/components/BookInfo'
export default {
  components: {
    BookInfo
  },
  data () {
    return {
      bookid: '1',
      info: {}
    }
  },
  methods: {
    async getDetail () {
      const info = await get('/weapp/bookdetail', {id: this.bookid})
      wx.setNavigationBarTitle({
        title: info.title
      })
      this.info = info
      console.log(info)
    }
  },
  mounted () {
    this.bookid = this.$root.$mp.query.id // mpvue特有的写法
    this.getDetail()
  }
}
</script>

<style lang="stylus" scoped>

</style>


