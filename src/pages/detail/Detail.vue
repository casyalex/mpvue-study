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
      <button class="btn" @click="addComment">
        评论
      </button>
    </div>
  </div>
</template>

<script>
import {get, post, showModal} from '@/util'
import BookInfo from '@/components/BookInfo'
export default {
  components: {
    BookInfo
  },
  data () {
    return {
      comments: '',
      userinfo: '',
      bookid: '',
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
      // console.log(info)
    },
    async getComments () {
      const comments = await get('/weapp/commentlist', {bookid: this.bookid})
      this.comments = comments
    },
    getGeo (e) {
      // 7enEFruoaol5sB8O1oiDMtW55sM93VRi
      // http://api.map.baidu.com/geocoder/v2/
      const ak = '7enEFruoaol5sB8O1oiDMtW55sM93VRi'
      let url = 'http://api.map.baidu.com/geocoder/v2/'
      if (e.target.value) {
        wx.getLocation({
          success: res => {
            wx.request({
              url,
              data: {
                location: `${res.latitude}, ${res.longitude}`,
                output: 'json',
                ak
              },
              success: res => {
                console.log(res)
                if (res.data.status === 0) {
                  this.location = res.data.result.addressComponent.city
                } else {
                  console.log('地理位置获取出错了')
                  this.location = '火星网友'
                }
              }
            })
            // console.log(res)
          }
        })
      } else {
        this.location = ''
      }
    },
    getPhone (e) {
      if (e.target.value) {
        const phoneInfo = wx.getSystemInfoSync()
        console.log(phoneInfo)
        this.phone = phoneInfo.model
      } else {
        this.phone = ''
      }
    },
    async addComment () {
      if (!this.comment) {
        return false
      }
      // 评论内容 型号 地理位置 图书id 用户的openid
      const data = {
        openid: this.userinfo.openId,
        bookid: this.bookid,
        comment: this.comment,
        phone: this.phone,
        location: this.location
      }
      console.log(data)
      try {
        await post('/weapp/addcomment', data)
        this.comment = ''
      } catch (error) {
        showModal('扑街', error.msg)
        console.log(error)
      }
    }
  },
  mounted () {
    this.bookid = this.$root.$mp.query.id // mpvue特有的写法
    this.getDetail()
    this.getComments()
    const userinfo = wx.getStorageSync('userinfo')
    if (userinfo) {
      this.userinfo = userinfo
    }
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


