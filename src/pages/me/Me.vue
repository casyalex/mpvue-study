<template>
  <div class="container">
    <div class="userinfo" >
      <img :src="userinfo.avatarUrl" alt="">
      <p>{{userinfo.nickName}}</p>
    </div>
    <button v-if='userinfo.openId' @click='scanBook' class='btn'>添加图书</button>
    <button v-else open-type="getUserInfo" lang="zh_CN" class='btn' @getuserinfo="login">点击登录</button>
    <!-- <button open-type="getUserInfo" lang="zh_CN" bindgetuserinfo="doLogin">获取用户信息</button> -->
  </div>
</template>
<script>
import qcloud from 'wafer2-client-sdk'
import {showSuccess} from '../../util'
export default {
  data () {
    return {
      userinfo: {
        avatarUrl: 'http://image.shengxinjing.cn/rate/unlogin.png',
        nickName: '未登陆'
      }
    }
  },
  methods: {
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
      } else {

      }
    }
  },
  created () {
    this.userinfo = wx.getStorageSync('userinfo')
  }
  // methods: {
  //   getWxLogin: function ({encryptedData, iv, userinfo}) {
  //     const self = this
  //     wx.login({
  //       success: function (loginResult) {
  //         console.log('loginResult', loginResult)
  //         var loginParams = {
  //           code: loginResult.code,
  //           encryptedData: encryptedData,
  //           iv: iv
  //         }
  //         qcloud.setLoginUrl(config.loginUrl)
  //         qcloud.requestLogin({
  //           loginParams,
  //           success () {
  //             // 获取用户信息
  //             qcloud.request({
  //               url: config.userUrl,
  //               login: true,
  //               success (userRes) {
  //                 wx.setStorageSync('userinfo', userRes.data.data)
  //                 self.userinfo = userRes.data.data
  //               }
  //             })
  //           },
  //           fail (error) {
  //             console.log(error)
  //             // showModal('登录失败', error)
  //           }
  //         })
  //       },
  //       fail: function (loginError) {
  //         // showModal('登录失败', loginError)
  //       }
  //     })
  //   }
  // }
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
