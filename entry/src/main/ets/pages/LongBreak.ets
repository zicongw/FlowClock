// entry/src/main/ets/pages/LongBreak.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { FadeSlideItem } from './FadeSlideItem';
import { VibrateUtil } from '../common/VibrateUtil';
@Entry
@Component
struct LongBreak {
    @State totalSecond: number = 30 * 60;
    @State remainSecond: number = 30 * 60;
    @State isRunning: boolean = false;
    @StorageLink("BreakCount") breakCount:number = 0
    @StorageLink("FlowWays") flowWays: number = 0
    //@StorageLink("BreakCount") breakCount: number = 0
    private timerId: number = -1;
    @State pageRefresh: number = 0

    aboutToAppear() {
        if(this.flowWays === 1){
            this.totalSecond = 15*60
            this.remainSecond = 15*60
        }
        if(this.flowWays === 2){
            this.totalSecond = 25*60
            this.remainSecond = 25*60
        }
        if(this.flowWays === 3){
            this.totalSecond = 25*60
            this.remainSecond = 25*60
        }
        if(this.flowWays === 4){
            this.totalSecond = 30*60
            this.remainSecond = 30*60
        }
    }

    pad(num: number): string {
        return num < 10 ? '0' + num : '' + num;
    }

    addFocusCount() {
        // 1. 获取当前值 (大写 Get)
        let currentCount = AppStorage.Get<number>('focus_count');
        if (currentCount === undefined) currentCount = 0;

        // 2. 写入新值 (大写 SetOrCreate)
        AppStorage.SetOrCreate('focus_count', currentCount + 1);
        VibrateUtil.shortVibrate();
        //console.info(`[TimerDown] 写入成功: ${currentCount + 1}`);
        promptAction.showToast({ message: '长休息结束了，继续专注吧!' });
    }

    build() {
        Column({ space: 40 }) {
            FadeSlideItem({delayMs: 0 }) {
                Text('长休息')
                    .fontSize(32)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#0F4441')
            }
            FadeSlideItem({delayMs: 200}) {
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
        //     angle: 160, // 倾斜角度，更有动感
        //     colors: [
        //         ['#ffe9eff5', 0.0], // 顶部：极淡的青蓝色（像天空）
        //         ['#ffeef8ef', 0.5], // 中间：淡薄荷绿
        //         ['#ffd0f3d1', 1.0]  // 底部：稍深的嫩绿
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
                    try {
                        if(this.flowWays == 1){
                            this.breakCount = 4
                            router.replaceUrl({url: 'pages/TimerDown_20'})
                        }
                        if(this.flowWays == 2){
                            this.breakCount = 4
                            router.replaceUrl({url: 'pages/TimerDown'})
                        }
                        if(this.flowWays == 3){
                            this.breakCount = 4
                            router.replaceUrl({url: 'pages/TimerDown_30'})
                        }
                        if(this.flowWays == 4){
                            this.breakCount = 2
                            router.replaceUrl({url: 'pages/TimerDown_50'})
                        }
                    } catch (err) {
                        console.error("跳转失败", JSON.stringify(err));
                    }
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

