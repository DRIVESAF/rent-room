import { getHomeDataApi } from '../api/home';
import { BannerListDataSource } from '../models/HomeData';
import SearchBar from '../views/Home/SearchBar'
import SwiperLayout from '../views/Home/SwiperLayout';

@Component
export default struct Home {
  @State bannerList: BannerListDataSource = new BannerListDataSource()
  // 获取首页数据函数
  getHomeData = async () => {
    const result = await getHomeDataApi()
    this.bannerList.setList(result.bannerList);
  }

  // 生命周期函数：初始化渲染时触发
  aboutToAppear(): void {
    this.getHomeData()
  }

  build() {
    Scroll() {
      Stack() {
        Column() {
          // 轮播图组件（使用prop通信）
          SwiperLayout({ bannerList: this.bannerList })
        }
        .width('100%')

        SearchBar()
      }.width('100%').alignContent(Alignment.TopStart)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)
  }
}