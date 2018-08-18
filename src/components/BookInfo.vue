<template>
  <div class="bookinfo">
    <div class="thumb">
      <img class="back"
        :src="info.image"
        mode="aspectFill">
      <img class="img"
        mode="aspectFit"
        :src="info.image">
      <div class="info">
        <div class="title">
          {{info.title}}
        </div>
        <div class="author">
          {{info.author}}
        </div>
      </div>
    </div>
    <div class="detail">
        <img class="avatar" mode="aspectFit" :src="userinfo.image" alt="">
        {{userinfo.nickName}}
      <div class="right text-primary">
        {{info.rate}}分
        <rate :value="info.rate"></rate>
      </div>
    </div>
    <div class="detail">
      {{info.publisher}}
      <div class="right">
        {{info.price}}
      </div>
    </div>
  </div>
</template>

<script>
import Rate from '@/components/Rate'
export default {
  components: {
    Rate
  },
  props: ['info'],
  computed: {
    userinfo () {
      return this.info.user_info || {}
    }
  }
}
</script>

<style lang="stylus" scoped>
.bookinfo
  font-size 14px
  .right
    float right
  .detail
    padding 5px 10px
    .avatar
      width 20px
      height 20px
      border-radius 50%
      vertical-align middle
  .thumb
    position relative
    width 750rpx
    height 500rpx
    overflow hidden
    .back
      filter blur(15px)
      width 100%
    .img
      position absolute
      width 100%
      height 300rpx
      left 0
      top 30rpx
    .info
      color #fff
      position absolute
      width 100%
      left 0
      top 330rpx
      text-align center
      .title
        font-size 20px
      .author
        font-size 14px
</style>


