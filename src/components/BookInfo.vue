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
  </div>
</template>

<script>
export default {
  props: ['info']
}
</script>

<style lang="stylus" scoped>
.bookinfo
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


