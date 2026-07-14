import vibrator from '@ohos.vibrator';

export class VibrateUtil {
    static shortVibrate() {
        try {
            vibrator.startVibration(
                {
                    type: 'time',
                    duration: 100
                },
                {
                    id: 0,
                    usage: 'notification'
                }
            );
            console.info("已触发振动，模拟器无体感，真机可见效果");
        } catch {
            console.info("振动触发失败");
        }
    }
}