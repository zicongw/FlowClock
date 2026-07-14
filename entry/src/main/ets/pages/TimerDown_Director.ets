import router from '@ohos.router';
import { initStorage, getNumberFlow } from '../common/Storage';
import common from '@ohos.app.ability.common';
import { FadeSlideItem } from './FadeSlideItem';

@Entry
@Component
struct TimerDown_Director {
    @StorageLink("Number_Flow") focusCount: number = 0
    ctx: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
    @StorageLink("FlowBreak") flowBreak: number = 0
    @StorageLink("FlowWays") flowWays: number = 0
    @StorageLink("BreakCount") breakCount: number = 0
    @State pageRefresh: number = 0
    async aboutToAppear() {
        await initStorage(this.ctx);
        const latestVal = await getNumberFlow();
        this.focusCount = latestVal;
    }

    async onPageShow() {
        const latestVal = await getNumberFlow();
        this.focusCount = latestVal;
        this.pageRefresh += 1
    }

    build() {
        Column({ space: 20 }) {
            //短时间专注20
            FadeSlideItem({delayMs: 0 }) {
                Column() {
                    Row() {
                        Image($r('app.media.timerlast'))
                            .width(30)
                            .height(30)
                        Text("短时间专注(20+5)")
                            .fontSize(26)
                            .fontWeight(FontWeight.Bold)
                            .fontColor('#1B5E20')
                        Image($r('app.media.right'))
                            .width(30)
                    }
                }
                .width('88%')
                .height(100)
                .margin({top: 50})
                .backgroundColor('rgba(255, 255, 255, 0.35)')
                .border({ width: 1.5, color: 'rgba(255, 255, 255, 0.4)', radius: 24 })
                .backdropBlur(25)
                .shadow({
                    radius: 15,
                    color: 'rgba(0, 0, 0, 0.1)',
                    offsetX: 0,
                    offsetY: 8
                })
                .borderRadius(20)
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)
                .onClick(async () => {
                    try {
                        this.flowWays = 1
                        this.breakCount = 4
                        await router.pushUrl({ url: 'pages/TimerDown_20' });
                    } catch {
                    }
                })
            }
            //标准专注25
            FadeSlideItem({delayMs: 200 }) {
                Column() {
                    Row() {
                        Image($r('app.media.timerlast'))
                            .width(30)
                            .height(30)
                        Text("标准专注(25+5)")
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
                .shadow({
                    radius: 15,
                    color: 'rgba(0, 0, 0, 0.1)',
                    offsetX: 0,
                    offsetY: 8
                })
                .borderRadius(20)
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)
                .onClick(async () => {
                    try {
                        this.flowWays = 2
                        this.breakCount = 4
                        await router.pushUrl({ url: 'pages/TimerDown' });
                    } catch {
                    }
                })
            }
            //长时间专注30
            FadeSlideItem({delayMs: 400 }) {
                Column() {
                    Row() {
                        Image($r('app.media.timerlast'))
                            .width(30)
                            .height(30)
                        Text("长时间专注(30+7)")
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
                .shadow({
                    radius: 15,
                    color: 'rgba(0, 0, 0, 0.1)',
                    offsetX: 0,
                    offsetY: 8
                })
                .borderRadius(20)
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)
                .onClick(async () => {
                    try {
                        this.flowWays = 3
                        this.breakCount = 4
                        await router.pushUrl({ url: 'pages/TimerDown_30' });
                    } catch {
                    }
                })
            }

            //深度专注50
            FadeSlideItem({delayMs: 600}) {
                Column() {
                    Row() {
                        Image($r('app.media.timerlast'))
                            .width(30)
                            .height(30)
                        Text("深度专注(50+10)")
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
                .shadow({
                    radius: 15,
                    color: 'rgba(0, 0, 0, 0.1)',
                    offsetX: 0,
                    offsetY: 8
                })
                .borderRadius(20)
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)
                .onClick(async () => {
                    try {
                        this.flowWays = 4
                        this.breakCount = 2
                        await router.pushUrl({ url: 'pages/TimerDown_50' });
                    } catch {
                    }
                })
            }
        }
        .width('100%')
        .height('100%')
        .linearGradient({
            angle: 0,
            colors: [
                ['#ffc3cedb', 0.0],
                ['#ffeeeff3', 1.0]
            ]
        })
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
}