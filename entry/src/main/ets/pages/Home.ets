import SwiperLayout from '../views/Home/SwiperLayout';
import SearchBar from '../views/Home/SearchBar';
import NavList from '../views/Home/NavList';
import TileList from '../views/Home/TileList';
import PlanList from '../views/Home/PlanList';
import RoomRecommend from '../views/Home/RoomRecommend';
import Ad from '../views/Home/Ad'
import ScrollContainer from '../components/ScrollContainer/Index'

import { getHomeDataApi } from '../api/home';
import { BannerListDataSource, INavList, IPlanList, ITileList, IColor } from '../model/HomeData';

import { PADDING, SHADOW_RADIUS } from '../constants/size';

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

  @Builder
  navBuilder($$: IColor) {
    // 搜索栏
    SearchBar({ bgColor: $$.bgColor, fontColor: $$.fontColor })
  }

  @Builder
  contentBuilder() {
    // 轮播图组件
    SwiperLayout({ bannerList: this.bannerList })
    Column() {
      NavList({ navList: this.navList })
      TileList({ tileList: this.tileList })
      PlanList({ planList: this.planList })
      // 广告
      Ad({ adPicture: this.adPicture })
    }.padding({ left: PADDING, right: PADDING })

    // 房源推荐
    RoomRecommend()
  }

  build() {
    ScrollContainer({
      navBuilderParam: this.navBuilder,
      // 改写成箭头函数，让 Builder 函数 this 指向组件实例
      contentBuilderParam: () => {
        this.contentBuilder()
      }
    })

  }
}