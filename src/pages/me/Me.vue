<template>
  <div class="container">
    <div class="userinfo" >
      <img :src="userinfo.avatarUrl" alt="">
      <p>{{userinfo.nickName}}</p>
    </div>
    <YearProgress />
    <button v-if='userinfo.openId' @click='scanBook' class='btn'>添加图书</button>
    <button v-else open-type="getUserInfo" lang="zh_CN" class='btn' @getuserinfo="login">点击登录</button>
    <!-- <button open-type="getUserInfo" lang="zh_CN" bindgetuserinfo="doLogin">获取用户信息</button> -->
  </div>
</template>
<script>
import qcloud from 'wafer2-client-sdk'
import {showSuccess, showModal, post} from '@/util'
import YearProgress from '@/components/YearProgress.vue'
export default {
  components: {
    YearProgress
  },
  data () {
    return {
      userinfo: {
        avatarUrl: 'http://image.shengxinjing.cn/rate/unlogin.png',
        nickName: '未登陆'
      }
    }
  },
  methods: {
    async addBook (isbnn) {
      const res = await post('/weapp/addbook', {
        isbn: isbnn,
        openid: this.userinfo.openId
      })
      showModal('添加成功', `${res.title}添加成功`)
      // if (res.data.code === 0 && res.data.data.title) {
      //   showModal('添加成功', `${res.data.data.title}添加成功`)
      // } else {
      //   showModal('添加失败', `${res.data}`)
      // }
    },
    scanBook () {
      wx.scanCode({
        success: (res) => {
          if (res.result) {
            this.addBook(res.result)
          }
        }
      })
    },
    login () {
      let user = wx.getStorageSync('userinfo')
      if (!user) {
        qcloud.login({
          success: (userinfo) => {
            console.log('登陆成功', userinfo)
            wx.setStorageSync('userinfo', userinfo)
            this.userinfo = userinfo
            showSuccess('登陆成功')
          },
          fail: (err) => {
            console.log('登陆失败', err)
          }
        })
      }
    }
  },
  created () {
    let user = wx.getStorageSync('userinfo')

    if (user) {
      this.userinfo = user
    }
  }
}
</script>

<style lang='stylus'>
.container
  padding: 0 30rpx

.userinfo
  margin: 100rpx 0 20rpx
  text-align: center
  img
    width: 150rpx
    height: 150rpx
    margin: 20rpx
    border-radius: 50%
  p
    font-size 16px
</style>
