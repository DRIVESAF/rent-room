import { getHomeDataApi } from '../api/home';
import { BannerListDataSource, INavList, IPlanList, ITileList } from '../models/HomeData';
import SearchBar from '../views/Home/SearchBar'
import SwiperLayout from '../views/Home/SwiperLayout';
import NavList from '../views/Home/NavList';
import { PADDING, SHADOW_RADIUS } from '../contants/size';
import TileList from '../views/Home/TileList';
import PlanList from '../views/Home/PlanList';
import RoomRecommend from '../views/Home/RoomRecommend';

@Component
export default struct Home {
  @State bannerList: BannerListDataSource = new BannerListDataSource()
  @State navList: INavList = []
  @State tileList: ITileList = []
  @State planList: IPlanList = []
  @State adPicture: string = ''
  // 获取首页数据函数
  getHomeData = async () => {
    const result = await getHomeDataApi()
    this.bannerList.setList(result.bannerList)
    this.navList = result.navList
    this.tileList = result.tileList
    this.planList = result.planList
    this.adPicture = result.adPicture
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
            // Tile组件
            TileList({ tileList: this.tileList })
            // 计划列表
            PlanList({ planList: this.planList })
            // 广告
            Image(this.adPicture)
              .width('100%')
              .height(60)
              .objectFit(ImageFit.Fill)
              .margin({ top: 10 })
              .shadow({
                offsetX: 0,
                offsetY: 0,
                radius: SHADOW_RADIUS,
                color: 'rgba(0,0,0,0.14)'
              })

          }.width('100%')
          .padding({ left: PADDING, right: PADDING })

          // 房源推荐
          RoomRecommend()

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