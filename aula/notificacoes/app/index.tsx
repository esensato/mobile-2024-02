import { Button, Text, View } from "react-native";
import * as Notifications from 'expo-notifications';
import Constants from 'expo-constants';
import * as Device from 'expo-device';

Notifications.setNotificationHandler({
  handleNotification: async () => {
    return {
      shouldShowAlert: true,
      shouldPlaySound: true,
      shouldSetBadge: true
    }
  },
});

export default function Index() {

  const enviarNotificacaoPush = async () => {

    const perm = await Notifications.getPermissionsAsync();
    if (perm.status === 'denied') {
      await Notifications.requestPermissionsAsync();
    } else {

      if (Device.isDevice) {
        console.log("Dispositivo real");
        const projectId = Constants?.expoConfig?.extra?.projectId;
        try {
          const pushTokenString = (
            await Notifications.getExpoPushTokenAsync({
              projectId,
            })
          ).data;
          console.log(pushTokenString);
          return pushTokenString;
        } catch (e: unknown) {
          console.log("Erro!!!!!!");
          console.log(e);
        }

      } else {
        console.log("Emulador");
      }

    }

  }

  const enviarNotificacaoLocal = async () => {

    try {

      const perm = await Notifications.getPermissionsAsync();

      console.log(perm);

      if (perm.status === 'denied') {
        await Notifications.requestPermissionsAsync();
      } else {
        console.log('Enviada a notificação...');
        Notifications.scheduleNotificationAsync({
          content: {
            title: 'Controle de Gastos',
            body: "Você está gastando muito!",
            data: { valor: 1000 }
          },
          trigger: {
            seconds: 5
          },
        });
      }



    } catch (e) {
      console.log(e);
    }

  }


  return (
    <View
      style={{
        flex: 1,
        justifyContent: "center",
        alignItems: "center",
      }}
    >
      <Button title="Enviar Notificação" onPress={enviarNotificacaoPush} />
    </View>
  );
}
