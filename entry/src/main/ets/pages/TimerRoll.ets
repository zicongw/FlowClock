import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import { addNumberFlow, getNumberFlow } from '../common/Storage';
import { FadeSlideItem } from './FadeSlideItem';
@Entry
@Component
struct TimerRoll {
    @State secondCount: number = 0;
    @State isRunning: boolean = false;
    private timerId: number = -1;
    @State pageRefresh: number = 0

    pad(num: number): string {
        return num < 10 ? '0' + num : '' + num;
    }

    async addFocusCount() {
        try {
            if (this.secondCount > 5) {
                await addNumberFlow();
                const newVal = await getNumberFlow();
                AppStorage.setOrCreate("Number_Flow", newVal);
                promptAction.showToast({ message: `专注完成！累计: ${newVal}次,休息一下吧!` });
            } else {
                promptAction.showToast({ message: '时间太短，未记录' });
            }
        } catch {}
    }

    build() {
        Column({ space: 40 }) {
            FadeSlideItem({delayMs: 0 }) {
                Text('正计时专注')
                    .fontSize(32)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#0F4441')
            }
            FadeSlideItem({delayMs: 200}) {
                Text(
                    `${this.pad(Math.floor(this.secondCount / 3600))}:` +
                        `${this.pad(Math.floor((this.secondCount % 3600) / 60))}:` +
                        `${this.pad(this.secondCount % 60)}`
                )
                    .fontSize(60)
                    .fontWeight(FontWeight.Bold)
                    .fontFamily('monospace')
                    .fontColor('#0F4441')
            }
            FadeSlideItem({delayMs: 400 }) {
                Row({ space: 30 }) {
                    Button() {
                        Image($r('app.media.finish'))
                            .width(50)
                    }
                    .width(80)
                    .height(80)
                    .backgroundColor('#217770')
                    .borderRadius(40)
                    .onClick(() => {
                        this.addFocusCount();
                        this.isRunning = false;
                        this.stopTimer();
                        this.secondCount = 0;
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
        if (this.timerId === -1) {
            this.timerId = setInterval(() => {
                this.secondCount++;
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