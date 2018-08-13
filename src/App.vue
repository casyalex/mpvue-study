<script>
// import {get} from './util'
import qcloud from 'wafer2-client-sdk'
import config from '@/config'
export default {
  async created () {
    // wx.request({
    //   url: config.host + '/weapp/demo',
    //   success: (res) => {
    //     console.log(res)
    //   }
    // })
    qcloud.setLoginUrl(config.loginUrl)
    // const res = await get('/weapp/demo')
    // console.log(res.data)
    // console.log('小程序启动了')
  }
}
</script>

<style lang="stylus">
.text-footer
  text-align center
  font-size 12px
  margin-bottom 5px
.text-primary
  color #EA5149
.btn
  color #fff
  background #EA5A49
  margin-bottom 10px
  padding 0 15px
  border-radius 2px
  font-size 16px
  line-height 40px
  height 40px
  width 100%
  &:active
    background #FA5A49
</style>
