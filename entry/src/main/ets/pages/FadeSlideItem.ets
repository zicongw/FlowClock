//entry/src/main/ets/pages/FadeSlideItem.ets
@Component
export struct FadeSlideItem {
    // 仅保留原来的delayMs，其他页面调用完全兼容
    delayMs: number = 0
    @BuilderParam content: () => void

    @State private animOpacity: number = 0
    @State private animOffsetY: number = 20

    runAnim() {
        this.animOpacity = 0
        this.animOffsetY = 20
        setTimeout(() => {
            animateTo({ duration: 400 }, () => {
                this.animOpacity = 1
                this.animOffsetY = 0
            })
        }, this.delayMs)
    }

    aboutToAppear() {
        this.runAnim()
    }

    build() {
        Column() {
            this.content()
        }
        .opacity(this.animOpacity)
        .translate({ y: this.animOffsetY })
    }
}