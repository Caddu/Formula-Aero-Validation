# Este Script Python gera perfis de aerofólio do tipo NACA 4, S1223, e423 e LNV109A no software Catia V5

# Autor: Carlos Eduardo Meireles do Amaral - Cadu

# Plano de REF: ZX

import win32com.client as win32     # deve ser instalado para permitir a automação com o CATIA (pip install pywin32)
import numpy as np                  # deve ser instalado (pip install numpy)
import math

# Função para o perfil NACA 4 dígitos
def naca4_airfoil(m, p, t, n_points=100):
    m = m / 100.0
    p = p / 10.0
    t = t / 100.0
    
    x = np.linspace(0, 1, n_points)
    
    yt = 5 * t * (0.2969 * np.sqrt(x) - 0.1260 * x - 0.3516 * x**2 + 0.2843 * x**3 - 0.1015 * x**4)
    
    if p == 0:
        # Para perfis NACA 00XX (camber line = 0)
        yc = np.zeros_like(x)
        dyc_dx = np.zeros_like(x)
    else:
        yc = np.where(x < p, 
                      m / p**2 * (2 * p * x - x**2), 
                      m / (1 - p)**2 * ((1 - 2 * p) + 2 * p * x - x**2))
        
        dyc_dx = np.where(x < p, 
                          2 * m / p**2 * (p - x), 
                          2 * m / (1 - p)**2 * (p - x))
    
    theta = np.arctan(dyc_dx)
    
    xu = x - yt * np.sin(theta)
    zu = yc + yt * np.cos(theta)  
    xl = x + yt * np.sin(theta)
    zl = yc - yt * np.cos(theta)  
    
    # Fechar a geometria no bordo de fuga
    xu[-1], zu[-1] = 1, 0  # Último ponto superior no bordo de fuga 
    xl[-1], zl[-1] = 1, 0  # Último ponto inferior no bordo de fuga 
    
    x_coords = np.concatenate([xu[::-1], xl])
    z_coords = np.concatenate([zu[::-1], zl])  
    
    # Inverter a coordenada z 
    z_coords = -z_coords
    
    return x_coords, z_coords

# Função para o perfil S1223 (Selig)
def s1223_airfoil():
    x_coords = np.array([1.00000, 0.99838, 0.99417, 0.98825, 0.98075, 0.97111, 0.95884, 0.94389, 0.92639, 0.90641, 0.88406, 0.85947, 0.83277, 0.80412, 0.77369, 0.74166, 0.70823, 0.67360, 0.63798, 0.60158, 0.56465, 0.52744, 0.49025, 0.45340, 0.41721, 0.38193, 0.34777, 0.31488, 0.28347, 0.25370, 0.22541, 0.19846, 0.17286, 0.14863, 0.12591, 0.10482, 0.08545, 0.06789, 0.05223, 0.03855, 0.02694, 0.01755, 0.01028, 0.00495, 0.00155, 0.00005, 0.00044, 0.00264, 0.00789, 0.01718, 0.03006, 0.04627, 0.06561, 0.08787, 0.11282, 0.14020, 0.17006, 0.20278, 0.23840, 0.27673, 0.31750, 0.36044, 0.40519, 0.45139, 0.49860, 0.54639, 0.59428, 0.64176, 0.68832, 0.73344, 0.77660, 0.81729, 0.85500, 0.88928, 0.91966, 0.94573, 0.96693, 0.98255, 0.99268, 0.99825, 1.00000])
    z_coords = np.array([0.00000, 0.00126, 0.00494, 0.01037, 0.01646, 0.02250, 0.02853, 0.03476, 0.04116, 0.04768, 0.05427, 0.06089, 0.06749, 0.07402, 0.08044, 0.08671, 0.09277, 0.09859, 0.10412, 0.10935, 0.11425, 0.11881, 0.12303, 0.12683, 0.13011, 0.13271, 0.13447, 0.13526, 0.13505, 0.13346, 0.13037, 0.12594, 0.12026, 0.11355, 0.10598, 0.09770, 0.08879, 0.07940, 0.06965, 0.05968, 0.04966, 0.03961, 0.02954, 0.01969, 0.01033, 0.00178, -0.00561, -0.01120, -0.01427, -0.01550, -0.01584, -0.01532, -0.01404, -0.01202, -0.00925, -0.00563, -0.00075, 0.00535, 0.01213, 0.01928, 0.02652, 0.03358, 0.04021, 0.04618, 0.05129, 0.05534, 0.05820, 0.05976, 0.05994, 0.05872, 0.05612, 0.05219, 0.04706, 0.04088, 0.03387, 0.02624, 0.01822, 0.01060, 0.00468, 0.00115, 0.00000])
    
    # Inverter a coordenada z 
    z_coords = -z_coords
    
    return x_coords, z_coords

# Função para o perfil e423 (Eppler)
def e423_airfoil():
    x_coords = np.array([1.00000, 0.99655, 0.98706, 0.97304, 0.95530, 0.93358, 0.90734, 0.87671, 0.84221, 0.80436, 0.76373, 0.72090, 0.67644, 0.63092, 0.58491, 0.53893, 0.49347, 0.44870, 0.40464, 0.36149, 0.31947, 0.27885, 0.23987, 0.20286, 0.16816, 0.13611, 0.10700, 0.08106, 0.05852, 0.03953,  0.02421, 0.01262, 0.00481, 0.00071, 0.00002, 0.00033, 0.00071, 0.00125, 0.00157, 0.00194,  0.00237, 0.00288, 0.00348, 0.00415, 0.00571, 0.00751, 0.01065, 0.01365, 0.02892, 0.04947,  0.07533, 0.10670, 0.14385, 0.18727, 0.23688, 0.29196, 0.35163, 0.41449, 0.47867, 0.54275, 0.60579, 0.66690, 0.72503, 0.77912, 0.82836, 0.87219, 0.91012, 0.94179, 0.96692, 0.98519, 0.99629, 1.00000])
    z_coords = np.array([0.00000, 0.00159, 0.00650, 0.01434, 0.02381, 0.03376, 0.04400, 0.05481, 0.06620, 0.07803, 0.09010, 0.10215, 0.11391, 0.12506, 0.13524, 0.14410, 0.15116, 0.15593, 0.15828, 0.15824, 0.15590, 0.15138, 0.14485, 0.13657, 0.12676, 0.11562, 0.10337, 0.09023, 0.07646, 0.06232,  0.04812, 0.03419, 0.02093, 0.00879, 0.00088, -0.00192, -0.00362, -0.00518, -0.00590, -0.00656,  -0.00717, -0.00771, -0.00823, -0.00874, -0.00969, -0.01057, -0.01177, -0.01266, -0.01485, -0.01482,  -0.01236, -0.00740, -0.00002, 0.00922, 0.01913, 0.02865, 0.03687, 0.04283, 0.04626, 0.04760,  0.04715, 0.04501, 0.04126, 0.03625, 0.03050, 0.02444, 0.01844, 0.01286, 0.00794, 0.00390,  0.00106, 0.00000])
    
    # Inverter a coordenada z 
    z_coords = -z_coords
    
    return x_coords, z_coords

# Função para o perfil LNV109A (Douglas/Liebeck)
def LNV109A_airfoil():
    x_coords = np.array([1.000000, 0.993938, 0.986151, 0.976665, 0.965515, 0.952740, 0.938385, 0.922500, 0.905141, 0.886369, 0.866250, 0.844856, 0.822261, 0.798545, 0.773791, 0.748087, 0.721524, 0.694194, 0.666193, 0.637621, 0.608579, 0.579167, 0.549490, 0.519653, 0.489759, 0.459916, 0.430226, 0.400796, 0.371729, 0.343127, 0.315090, 0.287718, 0.261106, 0.235350, 0.210538, 0.186758, 0.164095, 0.142628, 0.122432, 0.103579, 0.086135, 0.070162, 0.055715, 0.042846, 0.031599, 0.022015, 0.014127, 0.007963, 0.003544, 0.000887, 0.000000, 0.000887, 0.003544, 0.007963, 0.014127, 0.022015, 0.031599, 0.042846, 0.055715, 0.070162, 0.086135, 0.103579, 0.122432, 0.142628, 0.164095, 0.186758, 0.210538, 0.235350, 0.261106, 0.287718, 0.315090, 0.343127, 0.371729, 0.400796, 0.430226, 0.459916, 0.489759, 0.519653, 0.549490, 0.579167, 0.608579, 0.637621, 0.666193, 0.694194, 0.721524, 0.748087, 0.773791, 0.798545, 0.822261, 0.844856, 0.866250, 0.886369, 0.905141, 0.922500, 0.938385, 0.952740, 0.965515, 0.976665, 0.986151, 0.993938, 1.000000])
    z_coords = np.array([0.000000, 0.000543, 0.001101, 0.001787, 0.002657, 0.003737, 0.005056, 0.006639, 0.008509, 0.010690, 0.013204, 0.016069, 0.019300, 0.022912, 0.026914, 0.031312, 0.036110, 0.041303, 0.046886, 0.052846, 0.059164, 0.065813, 0.072756, 0.079934, 0.087276, 0.094701, 0.102116, 0.109249, 0.115295, 0.119496, 0.121941, 0.122784, 0.122185, 0.120264, 0.117155, 0.113001, 0.107922, 0.102024, 0.095430, 0.088284, 0.080712, 0.072825, 0.064730, 0.056528, 0.048318, 0.040194, 0.032222, 0.024369, 0.016413, 0.008081, 0.000000, -0.008081, -0.015530, -0.022138, -0.027272, -0.030455, -0.031544, -0.031202, -0.030105, -0.028554, -0.026666, -0.024529, -0.022211, -0.019767, -0.017246, -0.014689, -0.012132, -0.009608, -0.007151, -0.004782, -0.002532, -0.000425, 0.001516, 0.003265, 0.004793, 0.006064, 0.006997, 0.007552, 0.007802, 0.007826, 0.007672, 0.007376, 0.006968, 0.006477, 0.005927, 0.005340, 0.004735, 0.004130, 0.003538, 0.002973, 0.002443, 0.001955, 0.001515, 0.001126, 0.000789, 0.000505, 0.000273, 0.000093, -0.000038, -0.000097, 0.000000])

    # Inverter a coordenada z 
    z_coords = -z_coords
    
    return x_coords, z_coords


# Função para rotação dos pontos 
def rotate_points(x_coords, z_coords, angle):
    angle_rad = math.radians(angle)
    cos_angle = math.cos(angle_rad)
    sin_angle = math.sin(angle_rad)
    
    x_rot = x_coords * cos_angle - z_coords * sin_angle
    z_rot = x_coords * sin_angle + z_coords * cos_angle
    
    return x_rot, z_rot

# Função para adicionar o perfil ao CATIA 
def add_airfoil_to_catia(part, x_coords, z_coords, part_body_name, use_offset_plane, plane_position):
    bodies = part.Bodies
    part_body = bodies.Add()
    part_body.Name = part_body_name
    
    # Garantir que o Geometrical Set existe, ou criar um novo se não houver
    hybrid_bodies = part.HybridBodies
    try:
        geom_set = hybrid_bodies.Item("Airfoil gaps")
    except Exception as e:
        geom_set = hybrid_bodies.Add()
        geom_set.Name = "Airfoil gaps"
    
    # Definir o plano de trabalho como plano ZX
    hybridShapeFactory = part.HybridShapeFactory
    zx_plane = part.OriginElements.PlaneZX
    
    if use_offset_plane:
        new_plane = hybridShapeFactory.AddNewPlaneOffset(zx_plane, plane_position, True)
        geom_set.AppendHybridShape(new_plane)
        part.Update()
    else:
        new_plane = zx_plane

    # Criar um sketch no plano definido
    sketches = part_body.Sketches
    sketch = sketches.Add(new_plane)
    
    factory2D = sketch.OpenEdition()
    
    points = []
    for x, z in zip(x_coords, z_coords):  
        point = factory2D.CreatePoint(x, z)  
        points.append((x, z, point))  

    spline = factory2D.CreateSpline([p[2] for p in points])
    
    start_x, start_z, _ = points[0]  
    end_x, end_z, _ = points[-1]  
    
    factory2D.CreateLine(start_x, start_z, end_x, end_z)  
    
    sketch.CloseEdition()
    part.Update()
    
    return sketch  # Retornar o sketch para usar no blend



# ---------------  Aqui devemos definir os perfis para cada elemento ----------------------

# m -> Curvatura máxima (Camber max) [em % da corda] (camber line)
# p*10 -> Ponto de camber máximo [em % décimos da corda] a partir do Trailing edge
# T -> Espessura máx [em % da corda]

# angle_of_attack -> [degree] deve ser negativo pois o aerofólio está invertido em y
# chord_lenght -> [mm]


# Função para escolher entre NACA ou S1223
def select_airfoil(airfoil_type):
    if airfoil_type == "NACA_A":
        return naca4_airfoil(2, 4, 12)      # [m, p, T]
    elif airfoil_type == "NACA_B":
        return naca4_airfoil(4, 4, 14)      # [m, p, T]
    elif airfoil_type == "NACA_C":
        return naca4_airfoil(0, 0, 12)      # [m, p, T]
    elif airfoil_type == "S1223":
        return s1223_airfoil()    
    elif airfoil_type == "E423":
        return e423_airfoil()        
    elif airfoil_type == "LNV109A":
        return LNV109A_airfoil()       
    else:
        raise ValueError("Tipo de perfil inválido")


# Inicialização da conexão com o CATIA
catia = win32.Dispatch("CATIA.Application")
documents = catia.Documents

# Abrir o arquivo existente
part_document = documents.Open("D:\\AERO-zero\\CADs\\Catia Aero-zero\\FW-zero.CATPart")    ###### Aqui é caminho onde o código irá salvar o arquivo ######
part = part_document.Part


# ("D:\\AERO-zero\\CADs\\Catia Aero-zero\\FW-zero.CATPart") 


# -------------------Aqui definimos o gap e ovehang para entre cada perfil ---------------------------------

# A -> espaçamento entre o primeiro e segundo elemento
# B -> espacamento entre o segundo e terceiro elemento

# Definição dos gaps e overhangs
gap_A, overhang_A = 54.61, -32.31   # [mm, mm]
gap_B, overhang_B = 65.96, -45.77   # [mm, mm] 

x_positions = [0, 0, 0]
z_positions = [0, 0, 0]  

# ------- Aqui definimos a corda de cada elemento ---------

chord_lengths = [300, 106.15, 83.08, 300, 96.15, 58.08]  # [mm, mm, mm, mm, mm, mm]

#chord_lengths = [300, 123.85, 96.9, 350, 113.85, 71.9]  # [mm, mm, mm, mm, mm, mm]

x_positions[1] = chord_lengths[0] + overhang_A  
z_positions[1] = gap_A  

x_positions[2] = x_positions[1] + chord_lengths[1] + overhang_B
z_positions[2] = z_positions[1] + gap_B  
# -----------------------------------------------------

# Aqui configuramos a posição e a corda de cada perfil com as referências anteriores e também definimos o angulo de ataque e a posição do plano no eixo normal ao plano (eixo y, neste caso)

airfoil_parameters = [
    {"airfoil_type": "S1223", "name": "Main Element", "x_offset": x_positions[0], "z_offset": z_positions[0], "chord": chord_lengths[0], "angle": 7, "plane_position": 0, "use_offset_plane": False},
    {"airfoil_type": "S1223", "name": "Second Element", "x_offset": x_positions[1], "z_offset": z_positions[1], "chord": chord_lengths[1], "angle": 28, "plane_position": 0, "use_offset_plane": False},
    {"airfoil_type": "S1223", "name": "Third Element", "x_offset": x_positions[2], "z_offset": z_positions[2], "chord": chord_lengths[2], "angle": 46, "plane_position": 0, "use_offset_plane": False},
    
    {"airfoil_type": "S1223", "name": "Main Element_EXT", "x_offset": x_positions[0], "z_offset": z_positions[0], "chord": chord_lengths[3], "angle": 7, "plane_position": 725, "use_offset_plane": True},
    {"airfoil_type": "S1223", "name": "Second Element_EXT", "x_offset": x_positions[1], "z_offset": z_positions[1], "chord": chord_lengths[4], "angle": 15, "plane_position": 500, "use_offset_plane": True},
    {"airfoil_type": "S1223", "name": "Third Element_EXT", "x_offset": x_positions[2], "z_offset": z_positions[2] - 25, "chord": chord_lengths[5], "angle": 28, "plane_position": 500, "use_offset_plane": True}, 
    
]

# Adicionar perfis de aerofólios ao CATIA
for airfoil in airfoil_parameters:
    x_coords, z_coords = select_airfoil(airfoil["airfoil_type"])  
    
    x_coords *= airfoil["chord"]
    z_coords *= airfoil["chord"]  
    
    x_rot, z_rot = rotate_points(x_coords, z_coords, airfoil["angle"])  
    
    x_rot += airfoil["x_offset"]
    z_rot += airfoil["z_offset"]  
    
    add_airfoil_to_catia(part, x_rot, z_rot, airfoil["name"], airfoil["use_offset_plane"], airfoil["plane_position"])

# Atualizar e salvar as alterações
part.Update()
part_document.Save()

print("Perfis de aerofólios adicionados e arquivo salvo com sucesso!")



# Essa parametrização que o código forncece, fcilita a modificação fácil e rápida dos perfis multi elementos
# e a geração de vários perfis diferentes e com posições diferentes de forma muito mais rápida, facilitando muito a  
# análise de CFD e a construção do CAD.



# python D:\AERO-zero\Python\PyCatia_FWAF-S.py