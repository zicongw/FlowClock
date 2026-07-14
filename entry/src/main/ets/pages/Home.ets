//Home.ets
import router from '@ohos.router';
import { initStorage, getNumberFlow } from '../common/Storage';
import common from '@ohos.app.ability.common';
import { FadeSlideItem } from './FadeSlideItem';

@Component
export struct Home {
    @StorageLink("Number_Flow") focusCount: number = 0
    ctx: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
    // 控制卡片是否渲染
    @State showCards: boolean = true

    async aboutToAppear() {
        await initStorage(this.ctx);
        const latestVal = await getNumberFlow();
        this.focusCount = latestVal;
        // 首次打开直接显示卡片
        this.showCards = true;
    }

    async onPageShow() {
        const latestVal = await getNumberFlow();
        this.focusCount = latestVal;
        // 关键：先销毁所有卡片，再延时重建，强制触发子组件 aboutToAppear
        this.showCards = false;
        setTimeout(() => {
            this.showCards = true;
        }, 50)
    }

    build() {
        Column({ space: 20 }) {
            Blank().height(10)
            // 只有 showCards 为 true 才渲染所有动画卡片
            if (this.showCards) {
                FadeSlideItem({ delayMs: 0 }) {
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

                        Text(this.focusCount.toString() + " 次")
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
                    .shadow({
                        radius: 10,
                        color: 'rgba(46, 125, 50, 0.1)',
                        offsetX: 0,
                        offsetY: 4
                    })
                    .alignItems(HorizontalAlign.Center)
                    .justifyContent(FlexAlign.Center)
                }
                // 卡片 2：正计时
                FadeSlideItem({ delayMs: 200 }) {
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
                            await router.pushUrl({ url: 'pages/TimerRoll' });
                        } catch {
                        }
                    })
                }

                // 卡片 3：番茄钟
                FadeSlideItem({ delayMs: 400 }) {
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
                            await router.pushUrl({ url: 'pages/TimerDown_Director' });
                        } catch {
                        }
                    })
                }

                Blank()
                FadeSlideItem({ delayMs: 600 }) {
                    Text("在使用中遇到任何问题或提出建议请移步“信息”页面点击“Bug反馈与建议”")
                        .fontSize(14)
                        .fontColor('#666')
                        .textAlign(TextAlign.Center)
                        .padding({ bottom: 20, left: 16, right: 16 })
                }
            }
        }
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Transparent)
    }
}