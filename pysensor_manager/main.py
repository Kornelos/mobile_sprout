from random import randint
from fastapi import FastAPI
from pydantic import BaseModel
from datetime import datetime, timedelta

app = FastAPI()
sensorToData = dict()


@app.get("/{sensor_id}")
async def root(sensor_id):
    return get_data_for_sensor(sensor_id)


def get_data_for_sensor(sensor_id: str):
    if sensor_id not in sensorToData:
        generate_data(sensor_id, 48)

    return {"sensor_id": sensor_id, "hmi_data": sensorToData[sensor_id]}


def modify_hmi(current: int):
    # 5% for watering event
    water_drop = randint(0, 4)
    if randint(0, 20) == 5:
        return 100
    elif current - water_drop >= 0:
        return current - water_drop
    else:
        return 0


def generate_data(sensor_id: str, hours: int):
    now = datetime.now()
    data = []
    init_hmi = randint(0, 100)
    data.append({"hmi": init_hmi, "dt": now - timedelta(hours=hours)})
    for i in range(0, hours):
        data.append({"hmi": modify_hmi(data[i]["hmi"]), "dt": now - timedelta(hours=hours - i)})

    sensorToData[sensor_id] = data
    return data


class SensorDataPoint(BaseModel):
    hmi: int
    dtm: datetime
