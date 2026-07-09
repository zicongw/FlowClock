// entry/src/main/ets/pages/Home.ets
import router from '@ohos.router';

@Component
export struct Home {
    @StorageLink('focus_count') focusCount: number = 0;

    build() {
        Column({ space: 20 }) {
            Blank().height(10)


            Column() {
                Row() {
                    Image($r('app.media.chartbar'))
                        .width(30)
                        .height(30)
                    Text("本阶段已专注")
                        .fontSize(22)
                        .fontWeight(FontWeight.Medium)
                        .fontColor('#2E7D32')
                }


                Text(this.focusCount.toString()+" 次")
                    .fontSize(36)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#1B5E20')
                    .margin({ top: 5 })
            }
            .width('88%')
            .height(140)
            .backgroundColor('rgba(255, 255, 255, 0.75)')
            .backdropBlur(10)
            .borderRadius(24)
            .shadow({ radius: 10, color: 'rgba(46, 125, 50, 0.1)', offsetX: 0, offsetY: 4 })
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)

            // 卡片 2：正计时
            Column() {
                Row() {
                    Image($r('app.media.sandclock'))
                        .width(30)
                        .height(30)

                    Text("正计时专注")
                        .fontSize(26)
                        .fontWeight(FontWeight.Bold)
                        .fontColor('#1B5E20')
                    Image($r('app.media.right'))
                        .width(30)
                }
            }
            .width('88%')
            .height(100)
            .backgroundColor('rgba(255, 255, 255, 0.35)')
            .border({ width: 1.5, color: 'rgba(255, 255, 255, 0.4)', radius: 24 })
            .backdropBlur(25)
            .shadow({ radius: 15, color: 'rgba(0, 0, 0, 0.1)', offsetX: 0, offsetY: 8 })
            .borderRadius(20)
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .onClick(async () => {
                try {
                    await router.pushUrl({ url: 'pages/TimerRoll' });
                } catch (err) {
                    //console.error("跳转失败", JSON.stringify(err));
                }
            })

            // 卡片 3：倒计时
            Column() {
                Row() {
                    Image($r('app.media.timerlast'))
                        .width(30)
                        .height(30)
                    Text("番茄钟专注")
                        .fontSize(26)
                        .fontWeight(FontWeight.Bold)
                        .fontColor('#1B5E20')
                    Image($r('app.media.right'))
                        .width(30)
                }
            }
            .width('88%')
            .height(100)
            .backgroundColor('rgba(255, 255, 255, 0.35)')
            .border({ width: 1.5, color: 'rgba(255, 255, 255, 0.4)', radius: 24 })
            .backdropBlur(25)
            .shadow({ radius: 15, color: 'rgba(0, 0, 0, 0.1)', offsetX: 0, offsetY: 8 })
            .borderRadius(20)
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .onClick(async () => {
                try {
                    await router.pushUrl({ url: 'pages/TimerDown' });
                } catch (err) {
                    //console.error("跳转失败", JSON.stringify(err));
                }
            })

            Blank()
            Text("在使用中遇到任何问题或提出建议请移步“我的”页面点击“关于程序和Bug反馈与建议”")
                .fontSize(14)
                .fontColor('#666')
                .textAlign(TextAlign.Center)
                .padding({ bottom: 20, left: 16, right: 16 })
        }
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Transparent)
    }
}