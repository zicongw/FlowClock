//TimerDown_30.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { addNumberFlow, getNumberFlow } from '../common/Storage';
import { FadeSlideItem } from './FadeSlideItem';
import { VibrateUtil } from '../common/VibrateUtil';

@Entry
@Component
struct TimerDown {
    @State totalSecond: number = 30 * 60;
    @State remainSecond: number = 30 * 60;
    @State isRunning: boolean = false;
    @StorageLink("BreakCount") breakCount: number = 0
    private timerId: number = -1;
    @State pageRefresh: number = 0;

    async onPageShow() {
        // 变更状态，强制所有子组件重建，重新播放淡入动画
        this.pageRefresh += 1
    }
    pad(num: number): string {
        return num < 10 ? '0' + num : '' + num;
    }


    async addFocusCount() {
        try {
            await addNumberFlow();
            const newVal = await getNumberFlow();
            AppStorage.setOrCreate("Number_Flow", newVal);
            VibrateUtil.shortVibrate();
            promptAction.showToast({ message: '倒计时结束！次数+1,休息一下再继续吧！' });
        } catch {}
    }

    build() {
        Column({ space: 40 }) {
            FadeSlideItem({delayMs: 0 }) {
                Text('倒计时专注')
                    .fontSize(32)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#0F4441')
            }
            FadeSlideItem({delayMs: 200 }) {
                Text(
                    `${this.pad(Math.floor(this.remainSecond / 3600))}:` +
                        `${this.pad(Math.floor((this.remainSecond % 3600) / 60))}:` +
                        `${this.pad(this.remainSecond % 60)}`
                )
                    .fontSize(60)
                    .fontWeight(FontWeight.Bold)
                    .fontFamily('monospace')
                    .fontColor('#0F4441')
            }
            FadeSlideItem({delayMs: 400}) {
                Row({ space: 30 }) {
                    Button() {
                        Image($r('app.media.restart'))
                            .width(50)
                    }
                    .fontSize(16)
                    .fontColor(Color.White)
                    .width(80)
                    .height(80)
                    .backgroundColor('#217770')
                    .borderRadius(40)
                    .onClick(() => {
                        this.isRunning = false;
                        this.stopTimer();
                        this.remainSecond = this.totalSecond;
                    })

                    Button() {
                        Image(this.isRunning ? $r('app.media.stop') : $r('app.media.start'))
                            .width(50)
                            .height(50)
                    }
                    .width(100)
                    .height(100)
                    .backgroundColor('#0F6E68')
                    .borderRadius(50)
                    .shadow({
                        radius: 8,
                        color: '#1f000000',
                        offsetX: 0,
                        offsetY: 4
                    })
                    .onClick(() => {
                        if (this.isRunning) {
                            this.isRunning = false;
                            this.stopTimer();
                        } else {
                            this.isRunning = true;
                            this.startTimer();
                        }
                    })
                }
            }
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
            angle: 150,
            colors: [
                [0xb8c7d9, 0.0],
                [0xe3e9f0, 1.0]
            ]
        })
        // .linearGradient({
        //     angle: 160,
        //     colors: [
        //         ['#ffe9eff5', 0.0],
        //         ['#ffeef8ef', 0.5],
        //         ['#ffd0f3d1', 1.0]
        //     ]
        // })
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }

    startTimer() {
        this.stopTimer();
        if (this.remainSecond > 0) {
            this.timerId = setInterval(() => {
                this.remainSecond--;
                if (this.remainSecond <= 0) {
                    this.stopTimer();
                    this.isRunning = false;
                    this.addFocusCount().then(() => {
                        this.breakCount --;
                        if(this.breakCount === 0){
                            router.replaceUrl({url: "pages/LongBreak"})
                        }else {
                            router.replaceUrl({ url: "pages/Sleep" });
                        }
                    }).catch(() => {});
                }
            }, 1000);
        }
    }

    stopTimer() {
        if (this.timerId !== -1) {
            clearInterval(this.timerId);
            this.timerId = -1;
        }
    }

    aboutToDisappear() {
        this.stopTimer();
    }
}