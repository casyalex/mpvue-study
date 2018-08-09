<script>
import {get} from './util'
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
    const res = await get('/weapp/demo')
    console.log(res.data)
    console.log('小程序启动了')
  }
}
</script>

<style lang="stylus">

</style>
