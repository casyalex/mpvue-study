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
import config from '@/config'
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
      qcloud.setLoginUrl(config.loginUrl)
      qcloud.login({
        success: (userinfo) => {
          console.log('登陆成功', userinfo)
          this.userinfo = userinfo
        },
        fail: (err) => {
          console.log('登陆失败', err)
        }
      })
    }
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
  margin-top: 100rpx
  text-align: center
  img
    width: 150rpx
    height: 150rpx
    margin: 20rpx
    border-radius: 50%
</style>
