<template>
  <div>
    <BookInfo :info="info"></BookInfo>
    <div class="comment">
      <textarea v-model="comment"
                class="textarea"
                :maxlength="100"
                placeholder="请输入图书短评"></textarea>
      <div class="location">
        地理位置：
        <switch color="#EA5A49" :checked="location" @change="getGeo"></switch>
        <span class="text-primary">{{location}}</span>
      </div>
      <div class="phone">
        手机型号：
        <switch color="#EA5A49" :checked="phone" @change="getPhone"></switch>
        <span class="text-primary">{{phone}}</span>
      </div>
    </div>
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
      info: {},
      comment: '',
      location: '',
      phone: ''
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
    },
    getGeo () {},
    getPhone (e) {
      if (e.target.value) {
        const phoneInfo = wx.getSystemInfoSync()
        console.log(phoneInfo)
        this.phone = phoneInfo.model
      } else {
        this.phone = ''
      }
    }
  },
  mounted () {
    this.bookid = this.$root.$mp.query.id // mpvue特有的写法
    this.getDetail()
  }
}
</script>

<style lang="stylus" scoped>
.comment
  margin-top 10px
  .textarea
    width 730rpx
    height 200rpx
    background #eeeeee
    padding 10px
  .location,.phone
    margin-top 10px
    padding 5px 10px
</style>


