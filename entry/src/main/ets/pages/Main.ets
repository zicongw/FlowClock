// Main.ets
import { Home } from './Home';
import { Mine } from './Mine';
import router from '@ohos.router'; // 记得导入 router
import { drawing } from '@kit.ArkGraphics2D';

@Entry
@Component
struct Main {
    @State currentIndex: number = 0;
    // 选中态颜色：深一点的森林绿，保证对比度
    private readonly activeColor: string = '#1E5631';
    // 未选中态颜色：半透明白色，营造通透感
    private readonly inactiveColor: string = 'rgba(167, 167, 167, 0.60)';
    @State passedUserName: string = '未登录';

    aboutToAppear() {
        // 2. 在页面加载时，尝试获取路由参数
        try {
            const params = router.getParams() as Record<string, string>;
            if (params && params.username) {
                this.passedUserName = params.username;
            }
        } catch (e) {
            //console.error('获取参数失败');
        }
    }

    @Builder
    TabBarBuilder(title: string, targetIndex: number, iconRes: Resource) {
        Column() {
            Image(iconRes)
                .width(24)
                .height(24)
                .colorFilter(
                    drawing.ColorFilter.createBlendModeColorFilter(
                        this.currentIndex === targetIndex ? 0xFF1E5631 : 0xFFA7A7A7,
                        drawing.BlendMode.SRC_IN
                    )
                )
                .animation({ duration: 200 }) // 添加颜色切换动画

            Text(title)
                .fontSize(11)
                .fontWeight(this.currentIndex === targetIndex ? FontWeight.Bold : FontWeight.Normal)
                .fontColor(this.currentIndex === targetIndex ? this.activeColor : this.inactiveColor)
                .margin({ top: 2 })
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height('100%')
    }

    build() {
        Tabs({ barPosition: BarPosition.End }) {
            TabContent() {
                Home()
            }
            .tabBar(this.TabBarBuilder('专注', 0, $r('app.media.ic_icon')))  // 换了个更清新的叶子图标

            TabContent() {
                Mine({ userNameFromMain: this.passedUserName })
            }
            .tabBar(this.TabBarBuilder('我的', 1,  $r('app.media.userbar')))
        }
        .onChange((index: number) => {
            this.currentIndex = index;
        })

        .linearGradient({
            angle: 160,
            colors: [
                ['#ffe9eff5', 0.0], // 顶部：极淡的青蓝色（像天空）
                ['#ffeef8ef', 0.5], // 中间：淡薄荷绿
                ['#ffd0f3d1', 1.0]  // 底部：稍深的嫩绿
            ]
        })

        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

        // 导航栏样式优化
        .barHeight(60)
        .barMode(BarMode.Fixed)
        // 让导航栏背景透明，融入整体
        .backgroundColor(Color.Transparent)
        .divider({ strokeWidth: 0 }) // 去掉导航栏上方的分割线
    }
}