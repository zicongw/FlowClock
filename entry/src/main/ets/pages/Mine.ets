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
            // --- 头部用户信息区域 ---
            Row() {
                Image($r('app.media.user'))
                    .width(64)
                    .height(64)
                    //.fill('#FFFFFF') // 纯白头像框
                    //.stroke('#A5D6A7') // 绿色描边
                    //.strokeWidth(2)


                Column() {
                    Text(this.userNameFromMain)
                        .fontSize(20)
                        .fontWeight(FontWeight.Bold)
                        .fontColor('#1B5E20') // 深绿
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 16 })

                Blank()
            }
            .width('90%')
            .height(80)
            .alignItems(VerticalAlign.Center)
            // 头部也用半透明卡片
            .backgroundColor('rgba(255, 255, 255, 0.6)')
            .borderRadius(20)
            .padding({ left: 10, right: 10 })
            .margin({ top: 20 })

            // --- 菜单列表区域 ---
            Column() {
                this.MenuItem('退出登录', '🚪')
            }
            .width('90%')
            .margin({ top: 15 })
            .backgroundColor('rgba(255, 255, 255, 0.6)')
            .borderRadius(20)
            .padding({ top: 5, bottom: 5 })
            .onClick(() => {
                router.replace({ url: 'pages/Login' });
            })
            Column() {
                this.MenuItem('关于程序和Bug反馈与建议', '🐞')
            }
            .width('90%')
            .margin({ top: 15 })
            .backgroundColor('rgba(255, 255, 255, 0.6)')
            .borderRadius(20)
            .padding({ top: 5, bottom: 5 })
            .onClick(() => {
                router.pushUrl({url:"pages/Bugabout"});
            })
            Blank()
        }
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Transparent)
    }

    @Builder
    MenuItem(title: string, icon: string) {
        Row() {
            Text(icon).fontSize(20).margin({ right: 12 }).width(30)
            Text(title).fontSize(16).fontColor('#333').layoutWeight(1)
            Text('>').fontSize(14).fontColor('#CCC')
        }
        .width('100%')
        .height(56)
        .padding({ left: 20, right: 20 })
        .alignItems(VerticalAlign.Center)
    }
}