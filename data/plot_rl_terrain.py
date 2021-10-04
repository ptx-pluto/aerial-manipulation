from numpy import genfromtxt
import matplotlib.pyplot as plt
from matplotlib import animation
from matplotlib.ticker import MaxNLocator
import numpy as np
import math

def time_slice(data, t_start, t_end):
    assert t_start < t_end
    i_start = 0
    i_end = -1
    for i in range(data.shape[0]):
        i_start = i
        if data[i, 0] > t_start:
            break
    for i in range(i_start,data.shape[0]):
        i_end = i
        if data[i, 0] > t_end:
            break
    return data[i_start:i_end, :]

if __name__ == '__main__':

    # background_color = 'blue'
    # foreground_color = 'red'

    background_color = 'white'
    foreground_color = 'black'
    plot_color = 'mediumblue'

    data = genfromtxt('2021-09-01-18-10-51.labfloor.01.bag.full.csv', delimiter=',')
    #data = genfromtxt('2021-09-02-02-23-49.foam.02.bag.full.csv', delimiter=',')
    data = time_slice(data,5,math.inf)

    box_weight = 3

    # change size and resolution
    #plt.rcParams["font.weight"] = "bold"
    plt.rcParams["figure.figsize"] = (12, 7)
    plt.rcParams['figure.dpi'] = 300
    plt.rcParams['axes.linewidth'] = box_weight
    plt.rcParams['xtick.major.width'] = box_weight
    plt.rcParams['xtick.major.size'] = 8
    plt.rcParams['ytick.major.width'] = box_weight
    plt.rcParams['ytick.major.size'] = 8
    plt.rcParams['ytick.labelsize'] = 20
    plt.rcParams['xtick.labelsize'] = 20
    plt.rcParams['xtick.color'] = foreground_color
    plt.rcParams['xtick.direction'] = 'in'
    plt.rcParams['xtick.top'] = True
    plt.rcParams['ytick.color'] = foreground_color
    plt.rcParams['ytick.direction'] = 'in'
    plt.rcParams['lines.linewidth'] = 3
    plt.rcParams['lines.color'] = foreground_color
    plt.rcParams['figure.facecolor'] = background_color
    plt.rcParams['axes.facecolor'] = background_color
    plt.rcParams['axes.edgecolor'] = foreground_color
    plt.rcParams['axes.labelcolor'] = foreground_color
    plt.rcParams['axes.labelsize'] = 30
    plt.rcParams['axes.labelpad'] = 20


    # setup subplots
    fig, axs = plt.subplots(3, 1)

    fig.tight_layout(pad=1)

    rad2deg = 180./np.pi

    t_end = data[-1,0]

    action_scale = 0.1

    t1 = 20
    duration = 80
    t2 = t1+duration

    # contact
    #axs[0].plot(data[:, 8]+2.2, data[:, 7]-0.25, color="tab:red", linewidth=2)
    axs[0].plot(data[:, 8]+2.8, data[:, 7]-0.05, color="tab:red", linewidth=2)
    #axs[0].xaxis.set_ticklabels([])
    axs[0].set_yticks([-0.2,0,0.2])
    #axs[0].set_xlim((-2.8, 0.7))
    axs[0].set_xlim((0, 4))
    axs[0].set_ylim((-0.3, 0.3))
    axs[0].set_aspect('equal',adjustable='box')
    #axs[0].xaxis.tick_top()
    #axs[0].xaxis.set_label_position('top')
    #axs[0].tick_params(labelbottom=False, labeltop=True)
    # theta
    axs[1].plot(data[:, 0], data[:, 2], color=plot_color)
    axs[1].set_xlim((t1, t2))
    axs[1].set_ylim((0,1))
    axs[1].set_yticks([0,0.5,1])
    axs[1].xaxis.set_ticklabels([])
    axs[1].axhline(np.deg2rad(15), linestyle='--', linewidth=box_weight, dashes=(3, 3))
    axs[1].axhline(np.deg2rad(35), linestyle='--', linewidth=box_weight, dashes=(3, 3))
    # phi
    axs[2].plot(data[:, 0], data[:, 3], color=plot_color)
    axs[2].set_xlim((t1, t2))
    axs[2].set_ylim((-2.5, 2.5))
    axs[2].set_yticks([-1.5,0,1.5])
    #axs[3].xaxis.set_ticklabels([])


    # for ax in axs:
    #     #ax.xaxis.set_major_locator(MaxNLocator(integer=True))
    #     ax.xaxis.set_ticklabels([])

    plt.savefig("aerial_time_plot.png")

    #plt.show()