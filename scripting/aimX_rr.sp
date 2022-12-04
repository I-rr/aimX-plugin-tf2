#include <sourcemod>
#include <sdktools>

// Crea una función que se ejecutará cuando se detecte auto-aim
public Action OnAimbotDetected(int client)
{
    // Obtiene el nombre del jugador que usó el aimbot
    char name[64];
    GetClientName(client, name, sizeof(name));

    // Muestra un mensaje en la consola del servidor indicando que se ha detectado un aimbot
    PrintToServer("Se ha detectado un aimbot usado por el jugador %s", name);

    // Llama a una función para desconectar al jugador del servidor
    KickPlayer(client);

    return Plugin_Handled;
}

public void OnPlayerRunCommand(int client, int& buttons, int& impulse, float& forwardmove, float& sidemove, float& upmove, float velocity[3], CUserCmd* cmd)
{
    // Obtiene la dirección en la que el jugador está mirando
    Vector vecViewAngles;
    GetClientViewAngles(client, vecViewAngles);

    // Calcula la diferencia entre la dirección en la que el jugador mira y la dirección hacia la que dispara
    Vector vecShootAngles;
    AngleVectors(cmd->viewangles, vecShootAngles);
    Vector vecDiff = vecShootAngles - vecViewAngles;

    // Si la diferencia es menor a un cierto valor, se considera que el jugador está usando un aimbot
    if (vecDiff.Length() < 0.05)
    {
        // Llama a la función de detección de aimbot
        OnAimbotDetected(client);
    }
}
