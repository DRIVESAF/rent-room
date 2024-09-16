import { getHomeDataApi } from '../api/home';
import { BannerListDataSource, INavList, ITileList } from '../models/HomeData';
import SearchBar from '../views/Home/SearchBar'
import SwiperLayout from '../views/Home/SwiperLayout';
import NavList from '../views/Home/NavList';
import { PADDING } from '../contants/size';
import TileList from '../views/Home/TileList';

@Component
export default struct Home {
  @State bannerList: BannerListDataSource = new BannerListDataSource()
  @State navList: INavList = []
  @State tileList: ITileList = []
  // 获取首页数据函数
  getHomeData = async () => {
    const result = await getHomeDataApi()
    this.bannerList.setList(result.bannerList)
    this.navList = result.navList
    this.tileList = result.tileList
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
          Column() {
            // 导航栏排在轮播图下
            NavList({ navList: this.navList })

            TileList({ tileList: this.tileList })
          }.width('100%')
          .padding({ left: PADDING, right: PADDING })

        }
        .width('100%')

        // 搜索框堆叠在轮播图上
        SearchBar()
      }.width('100%').alignContent(Alignment.TopStart)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)
  }
}