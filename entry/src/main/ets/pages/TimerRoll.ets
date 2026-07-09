

// entry/src/main/ets/pages/TimerRoll.ets
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';

@Entry
@Component
struct TimerRoll {
    @State secondCount: number = 0;
    @State isRunning: boolean = false;
    private timerId: number = -1;

    pad(num: number): string {
        return num < 10 ? '0' + num : '' + num;
    }

    addFocusCount() {
        // 只有当时间大于5秒才记录，防止误触
        if (this.secondCount > 5) {
            // 1. 获取当前值 (注意是大写 Get)
            let currentCount = AppStorage.Get<number>('focus_count');
            if (currentCount === undefined) currentCount = 0;

            // 2. 计算新值
            let newCount = currentCount + 1;

            // 3. 写入新值 (注意是大写 SetOrCreate，这一步才会写入硬盘)
            AppStorage.SetOrCreate('focus_count', newCount);

            //console.info(`[TimerRoll] 写入成功: ${newCount}`);
            promptAction.showToast({ message: `专注完成！累计: ${newCount}次,休息一下吧!` });
        } else {
            promptAction.showToast({ message: '时间太短，未记录' });
        }
    }

    build() {
        Column({ space: 40 }) {
            Text('正计时专注')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#0F4441')

            Text(
                `${this.pad(Math.floor(this.secondCount / 3600))}:` +
                    `${this.pad(Math.floor((this.secondCount % 3600) / 60))}:` +
                    `${this.pad(this.secondCount % 60)}`
            )
                .fontSize(60)
                .fontWeight(FontWeight.Bold)
                .fontFamily('monospace')
                .fontColor('#0F4441')

            Row({ space: 30 }) {
                Button(){
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
                .shadow({ radius: 8, color: '#1f000000', offsetX: 0, offsetY: 4 })
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
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
            angle: 160, // 倾斜角度，更有动感
            colors: [
                ['#ffe9eff5', 0.0], // 顶部：极淡的青蓝色（像天空）
                ['#ffeef8ef', 0.5], // 中间：淡薄荷绿
                ['#ffd0f3d1', 1.0]  // 底部：稍深的嫩绿
            ]
        })
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