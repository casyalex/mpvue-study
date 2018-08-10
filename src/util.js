// 工具函数库

import config from './config'

export function get (url) {
  return new Promise((resolve, reject) => {
    wx.request({
      url: config.host + url,
      success: (res) => {
        if (res.data.code === 0) {
          resolve(res)
        } else {
          reject(res.data)
        }
      }
    })
  })
}

export function showSuccess (text) {
  wx.showToast({
    title: text,
    icon: 'success',
    duration: 2000
  })
}
