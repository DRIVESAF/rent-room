import Home from './Home'
import See from './See'
import Service from './Service'
import My from './My'
import Discover from './Discover'

@Entry
@Component
struct Index {
  @State CurrentTabBarIndex: number = 0;

  @Builder
  tabBarBuilder(image: Resource, activeImage: Resource, text: string, index: number) {
    Column() {
      Image(this.CurrentTabBarIndex === index ? activeImage : image).width(28).height(28)
      Text(text)
        .fontSize(10)
        .fontColor(this.CurrentTabBarIndex === index ? $r('app.color.black') : $r('app.color.gray_text'))
    }
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Home()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_home'), $r('app.media.tabbar_home_active'), '首页', 0))

      TabContent() {
        See()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_see'), $r('app.media.tabbar_see_active'), '想看', 1))

      TabContent() {
        Service()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_service'), $r('app.media.tabbar_service_active'), '服务', 2))

      TabContent() {
        Discover()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_discover'), $r('app.media.tabbar_discover_active'), '发现', 3))

      TabContent() {
        My()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_my'), $r('app.media.tabbar_my_active'), '我的', 4))
    }
    .barHeight(50) //默认值是56
    .scrollable(false)
    .onChange((index: number) => {
      this.CurrentTabBarIndex = index;
    })
  }
}