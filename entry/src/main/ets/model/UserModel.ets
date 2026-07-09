// entry/src/main/ets/model/UserModel.ets
import dataPreferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';

export class User {
    username: string = '';
    password: string = '';
    days: number = 0; // 专注天数
}

export class DataController {
    private static instance: DataController;
    private preferences: dataPreferences.Preferences | null = null;
    private isInitialized: boolean = false;

    private constructor() {}

    static getInstance(): DataController {
        if (!DataController.instance) {
            DataController.instance = new DataController();
        }
        return DataController.instance;
    }

    async init(context: common.UIAbilityContext) {
        if (this.isInitialized) return;
        try {
            this.preferences = await dataPreferences.getPreferences(context, 'MyStore');
            this.isInitialized = true;
        } catch (e) {
            console.error('Init preferences failed: ' + JSON.stringify(e));
        }
    }

    // 【新增】增加专注天数
    async incrementDays() {
        if (!this.preferences) return;
        try {
            let currentDays = await this.preferences.get('days', 0) as number;
            currentDays++;
            await this.preferences.put('days', currentDays);
            await this.preferences.flush();
            console.info('Days incremented to: ' + currentDays);
        } catch (e) {
            console.error('Increment days failed: ' + JSON.stringify(e));
        }
    }

    async getCurrentUser(): Promise<User> {
        if (!this.preferences) return new User();
        const user = new User();
        try {
            user.username = await this.preferences.get('username', '') as string;
            user.password = await this.preferences.get('password', '') as string;
            user.days = await this.preferences.get('days', 0) as number;
        } catch (e) {
            console.error('Get user failed: ' + JSON.stringify(e));
        }
        return user;
    }

    async saveUser(user: User) {
        if (!this.preferences) return;
        try {
            await this.preferences.put('username', user.username);
            await this.preferences.put('password', user.password);
            await this.preferences.put('days', user.days);
            await this.preferences.flush();
        } catch (e) {
            console.error('Save user failed: ' + JSON.stringify(e));
        }
    }

    async logout() {
        if (!this.preferences) return;
        try {
            await this.preferences.clear();
            await this.preferences.flush();
        } catch(e) {}
    }
}