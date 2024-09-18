import SwiperLayout from '../views/Home/SwiperLayout';
import SearchBar from '../views/Home/SearchBar';
import NavList from '../views/Home/NavList';
import TileList from '../views/Home/TileList';
import PlanList from '../views/Home/PlanList';
import RoomRecommend from '../views/Home/RoomRecommend';

import { getHomeDataApi } from '../api/home';
import { BannerListDataSource, INavList, IPlanList, ITileList } from '../models/HomeData';

import { PADDING, SHADOW_RADIUS } from '../contants/size';

@Component
export default struct Home {
  // 首页数据
  @State bannerList: BannerListDataSource = new BannerListDataSource()
  @State navList: INavList = [];
  @State tileList: ITileList = [];
  @State planList: IPlanList = [];
  @State adPicture: string = '';
  scrollY: number = 0;
  @State bgColor: string = 'rgba(255, 255, 255, 0)'
  @State fontColor: string = 'rgb(255, 255, 255)'
  // 获取首页数据
  getHomeData = async () => {
    const result = await getHomeDataApi()
    this.bannerList.setList(result.bannerList)
    this.navList = result.navList
    this.tileList = result.tileList
    this.planList = result.planList
    this.adPicture = result.adPicture
  }

  // 组件生命周期
  aboutToAppear() {
    this.getHomeData()
  }

  // 处理滚动
  handleScroll = (xOffset: number, yOffset: number) => {
    this.scrollY += yOffset;
    if (this.scrollY < 0) {
      this.scrollY = 0;
    }
    this.calcColor()
  }
  // 计算颜色
  calcColor = () => {
    // 滚动计算的 scrollY 的值到达顶部可能不是 0，给点误差
    if (this.scrollY > 10) {
      this.bgColor = 'rgba(255, 255, 255, 1)'
      this.fontColor = 'rgb(0, 0, 0)'
    } else {
      this.bgColor = 'rgba(255, 255, 255, 0)'
      this.fontColor = 'rgb(255, 255, 255)'
    }
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          SwiperLayout({ bannerList: this.bannerList })

          Column() {
            NavList({ navList: this.navList })
            TileList({ tileList: this.tileList })
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
          }.padding({ left: PADDING, right: PADDING })

          RoomRecommend()
        }
        .justifyContent(FlexAlign.Start)
      }
      .height('100%')
      .align(Alignment.TopStart)
      .scrollBar(BarState.Off)
      .onDidScroll(this.handleScroll)

      SearchBar({ bgColor: this.bgColor, fontColor: this.fontColor })
    }
    .height('100%')
    .alignContent(Alignment.TopStart)
  }
}