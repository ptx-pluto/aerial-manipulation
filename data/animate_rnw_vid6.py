from numpy import genfromtxt
import matplotlib.pyplot as plt
from matplotlib import animation
from matplotlib.ticker import MaxNLocator
import numpy as np


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

    background_color = 'black'
    foreground_color = 'white'
    #plot_color = 'tab:blue'
    plot_color = foreground_color

    data = genfromtxt('2021-07-01-04-24-56.vid2.ground.55.120.bag.full.csv', delimiter=',')

    # change size and resolution
    plt.rcParams["figure.figsize"] = (10,10)
    plt.rcParams['figure.dpi'] = 100
    plt.rcParams['axes.linewidth'] = 0.5
    plt.rcParams['xtick.color'] = foreground_color
    plt.rcParams['xtick.direction'] = 'in'
    plt.rcParams['xtick.top'] = True
    plt.rcParams['ytick.color'] = foreground_color
    plt.rcParams['ytick.left'] = False
    plt.rcParams['ytick.right'] = True
    plt.rcParams['ytick.labelleft'] = False
    plt.rcParams['ytick.labelright'] = True
    plt.rcParams['ytick.direction'] = 'in'
    plt.rcParams['lines.linewidth'] = 1.5
    plt.rcParams['lines.color'] = foreground_color
    plt.rcParams['figure.facecolor'] = background_color
    plt.rcParams['axes.facecolor'] = background_color
    plt.rcParams['axes.edgecolor'] = foreground_color
    plt.rcParams['axes.labelcolor'] = foreground_color
    plt.rcParams['axes.labelsize'] = 20
    plt.rcParams['axes.labelpad'] = 20

    # setup subplots
    fig, ax = plt.subplots(1, 1)
    fig.tight_layout()
    #ax.set_aspect('equal')

    fps = 60
    speed = 4
    interval = (1000/fps)  # ms between frames
    duration_sec = data[-1, 0]
    frames = int(duration_sec * 1000 / interval / speed)
    t_start = 0
    t_window = 10
    t_end = t_start-t_window

    ax.set_xlim((-1, 1))
    ax.set_ylim((-3, 3))
    ax.set_xticks([-0.5, 0, 0.5])
    ax.set_yticks(range(-2, 3))

    just_static = False

    if not just_static:
        line, = ax.plot([],[],color=plot_color)
        cursor, = ax.plot([],[], marker='o', color='red', markersize=20)

    def init():
        cursor.set_data([0],[0])
        return line, cursor

    def animate(i):
        offset = i*speed*interval/1000.
        start = max(0,offset-20)
        if offset > 0.1:
            seg = time_slice(data, start, offset)
            line.set_data(seg[:, 3], seg[:, 6])
            cursor.set_data([seg[-1,3]],[seg[-1,6]])
        return line, cursor

    def render():
        Writer = animation.writers['ffmpeg']
        writer = Writer(fps=fps, metadata=dict(artist='Me'), bitrate=1800)
        anim = animation.FuncAnimation(fig, animate, init_func=init, frames=frames, blit=False)
        anim.save('vid9.mp4', writer=writer)

    def preview():
        anim = animation.FuncAnimation(fig, animate, init_func=init, frames=frames, interval=interval, blit=False)
        plt.show()

    if just_static:
        ax.plot(data[:, 3], data[:, 6], color=plot_color)
        plt.show()
    else:
        render()
        #preview()
