<template>
  <div class="container">
    <div class="userinfo" >
      <img :src="userinfo.avatarUrl" alt="">
      <p>{{userinfo.nickName}}</p>
    </div>
    <YearProgress></YearProgress>
    <button v-if='userinfo.openId' @click='scanBook' class='btn'>添加图书</button>
    <button v-else open-type="getUserInfo" lang="zh_CN" class='btn' @getuserinfo="login">点击登录</button>
  </div>
</template>

<script>
import qcloud from 'wafer2-client-sdk'
import YearProgress from '@/components/YearProgress'
import {showSuccess, post, showModal} from '@/util'
import config from '@/config'
export default {
  components: {
    YearProgress
  },
  data () {
    return {
      userinfo: {
        avatarUrl: 'http://image.shengxinjing.cn/rate/unlogin.png',
        nickName: ''
      }
    }
  },
  methods: {
    async addBook (isbn) {
      const res = await post('/weapp/addbook', {
        isbn,
        openid: this.userinfo.openId
      })
      showModal('添加成功', `${res.title}添加成功`)
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
    getWxLogin: function ({encryptedData, iv, userinfo}) {
      const self = this
      wx.login({
        success: function (loginResult) {
          console.log('loginResult', loginResult)
          var loginParams = {
            code: loginResult.code,
            encryptedData: encryptedData,
            iv
          }
          qcloud.setLoginUrl(config.loginUrl)
          qcloud.requestLogin({
            loginParams,
            success () {
              qcloud.request({
                url: config.useUrl,
                login: true,
                success (userRes) {
                  showSuccess('登录成功')
                  wx.setStorageSync('userinfo', userRes.data.data)
                  self.userinfo = userRes.data.data
                }
              })
            },
            fail (error) {
              showModal('登录失败', error)
            }
          })
        },
        fail: function(loginError) {
          showModal('登录失败', loginError)
        }
      })
    },

    login (e) {
      const self = this
      wx.getSetting({
        success: function (res) {
          if (res.authSetting['scope.userInfo']) {
            wx.checkSession({
              success: function () {
                showSuccess('登录成功')
              },
              fail: function () {
                qcloud.clearSession()
                var options = {
                  encryptedData: e.mp.detail.encryptedData,
                  iv: e.mp.detail.iv,
                  userinfo: e.mp.detail.userInfo
                }
                self.getWxLogin(options)
              }
            })
          } else {
            showModal('用户未授权', e.mp.detail.errMsg)
          }
        }
      })
    },
    onShow () {
      let userinfo = wx.getStorageSync('userinfo')
      if (userinfo) {
        this.userinfo = userinfo
      }
    }
  }
}
</script>

<style lang='stylus'>
.container
  padding:0 30rpx
.userinfo
  margin-top: 100rpx
  text-align: center
  img
    width: 150rpx
    height: 150rpx
    margin: 20rpx
    border-radius: 50%
</style>
