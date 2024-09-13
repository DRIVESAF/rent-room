import axios from '@ohos/axios';
import { promptAction } from '@kit.ArkUI';
import type { AnyObject } from '../../models/HttpModel';

const request = axios.create({
  baseURL: 'http://192.168.37.44:6060'
})

request.interceptors.request.use(
  (config) => {
    return config;
  }
)

request.interceptors.response.use(
  (response) => {
    if (response.data.code === 200) {
      return response.data.data;
    } else {
      // 错误提示
      promptAction.showToast(response.data.message)
      return Promise.reject(response.data.message)
    }
  },
  (error) => {
    // 错误提示
    promptAction.showToast(error.message)
    return Promise.reject(error.message)
  },
)

export default class Http {
  get<T>(url: string, params?: AnyObject) {
    return request.get<any, T>(url, {
      params
    })
  }

  post<T>(url: string, data?: AnyObject) {
    return request.get<any, T>(url, data)
  }

  put<T>(url: string, data?: AnyObject) {
    return request.get<any, T>(url, data)
  }

  delete<T>(url: string, params?: AnyObject) {
    return request.get<any, T>(url, {
      params
    })
  }
}