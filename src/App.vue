<script>
import {get} from './util'
export default {
  async created () {
    // wx.request({
    //   url: config.host + '/weapp/demo',
    //   success: (res) => {
    //     console.log(res)
    //   }
    // })
    const res = await get('/weapp/demo')
    console.log(res.data)
    console.log('小程序启动了')
  }
}
</script>

<style lang="stylus">

</style>
