public OnPlayerRunCommand(client, &buttons, &impulse, &vel[3], &angles[3], &oldbuttons, &oldimpulse)
{
    // Obtenemos la dirección de mira actual del jugador
    Vector current_aim = GetClientEyeAngles(client);

    // Si la dirección de mira cambió demasiado rápido,
    // es posible que el jugador esté usando un aimbot
    if (current_aim.x - last_aim.x > AIMBOT_THRESHOLD || current_aim.y - last_aim.y > AIMBOT_THRESHOLD)
    {
        // Incrementamos un contador de sospechas de uso de aimbot
        aimbot_suspicions[client]++;

        // Si el jugador superó un cierto umbral de sospechas,
        // lo desconectamos del servidor
        if (aimbot_suspicions[client] > AIMBOT_SUSPICION_THRESHOLD)
        {
            KickClient(client);
        }
    }

    // Actualizamos la dirección de mira del jugador
    last_aim[client] = current_aim;
}
