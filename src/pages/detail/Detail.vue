<template>
  <div>
    <BookInfo :info="info"></BookInfo>
    <CommentList :comments="comments"></CommentList>
    <div class="comment" v-if="showAdd">
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
    <div v-else class="text-footer">
      未登录或者你已经评论过了
    </div>
    <button class="btn" open-type="share">转发给好友</button>
  </div>
</template>

<script>
import {get, post, showModal} from '@/util'
import BookInfo from '@/components/BookInfo'
import CommentList from '@/components/CommentList'
export default {
  components: {
    BookInfo,
    CommentList
  },
  data () {
    return {
      comments: [],
      userinfo: '',
      bookid: '',
      info: {},
      comment: '',
      location: '',
      phone: ''
    }
  },
  computed: {
    showAdd () {
      // 没登录
      if (!this.userinfo.openId) {
        return false
      }
      // 评论列表里有自己的openId
      if (this.comments.filter(v => v.openid === this.userinfo.openId).length) {
        return false
      } else {
        return true
      }
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
      this.comments = comments.list
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
        // 提交完评论 刷一下评论列表，加载新评论
        this.getComments()
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
  },
  onShareAppMessage (res) {
    if (res.from === 'button') {
      // 来自页面内转发按钮
      // console.log(res.target)
    }
    return {
      title: `分享给你 ${this.info.title}`
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


