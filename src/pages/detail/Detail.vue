<template>
  <div>
    图书{{bookid}}
  </div>
</template>

<script>
import {get} from '@/util'
export default {
  data () {
    return {
      bookid: '1'
    }
  },
  methods: {
    async getDetail () {
      const info = await get('/weapp/bookdetail', {id: this.bookid})
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


