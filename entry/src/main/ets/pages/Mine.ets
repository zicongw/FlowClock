// Mine.ets
import router from '@ohos.router';
@Component

export struct Mine {
    @State userName: string = '未登录';
    @Link userNameFromMain: string;
    aboutToAppear() {
        // 获取路由传过来的参数
        const params = router.getParams() as Record<string, Object>;
        if (params && params.username) {
            this.userName = params.username as string;
        }
    }
    build() {
        Column() {
            Column() {
                this.MenuItem('关于程序', $r('app.media.about'))
            }
            .width('90%')
            .margin({ top: 15 })
            .backgroundColor('rgba(255, 255, 255, 0.6)')
            .borderRadius(20)
            .padding({ top: 5, bottom: 5 })
            .onClick(() => {
                router.pushUrl({url:"pages/About"});
            })
            Column() {
                this.MenuItem('Bug反馈与建议', $r('app.media.bug'))
            }
            .width('90%')
            .margin({ top: 15 })
            .backgroundColor('rgba(255, 255, 255, 0.6)')
            .borderRadius(20)
            .padding({ top: 5, bottom: 5 })
            .onClick(() => {
                router.pushUrl({url:"pages/Bug"});
            })
            Blank()
        }
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Transparent)
    }

    @Builder
    MenuItem(title: string, icon: Resource) {
        Row() {
            Image(icon) .margin({ right: 12 }).width(30)
            Text(title).fontSize(16).fontColor('#333').layoutWeight(1)
            Text('>').fontSize(14).fontColor('#CCC')
        }
        .width('100%')
        .height(56)
        .padding({ left: 20, right: 20 })
        .alignItems(VerticalAlign.Center)
    }
}